import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/entity/sepet_yemekler.dart';
import 'package:yemek/data/entity/yemekler.dart';
import 'package:yemek/ui/cubit/sepetsayfa_cubit.dart';
import 'package:yemek/ui/views/detaysayfa.dart';

class Sepetsayfa extends StatefulWidget {
  const Sepetsayfa({super.key});

  @override
  State<Sepetsayfa> createState() => _SepetsayfaState();
}

class _SepetsayfaState extends State<Sepetsayfa> {
  String kullanici_adi="faruk";
  int top=0;
  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemeklerYukle(kullanici_adi);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sepetim"),backgroundColor: Colors.red,),
      body:BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
        builder: (context,sepetyemeklerlistesi) {
          if (sepetyemeklerlistesi.isNotEmpty) {

            int toplamTutar = sepetyemeklerlistesi.fold(0, (total, sepetyemek) {
              return total +
                  (int.parse(sepetyemek.yemek_siparis_adet) *
                      int.parse(sepetyemek.yemek_fiyat));
            });

            return Column(children: [

            Expanded(child:
              ListView.builder(
              itemCount: sepetyemeklerlistesi.length,
              itemBuilder: (context, indeks) {
                var sepetyemek = sepetyemeklerlistesi[indeks];
                return GestureDetector(
                  child: Card(
                    child: SizedBox(height: 100,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:18),
                                child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${sepetyemek.yemek_resim_adi}",width: 70,height: 70),
                              ),
                            ],
                          ),
                          Padding(padding: const EdgeInsets.all(8.0),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(sepetyemek.yemek_adi,
                                  style: const TextStyle(fontSize: 20),),
                                Text("Fiyat: £${sepetyemek.yemek_fiyat}"),
                                Text("adet: ${sepetyemek.yemek_siparis_adet}"),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('£${int.parse(sepetyemek.yemek_siparis_adet) * int.parse(sepetyemek.yemek_fiyat)} ',style: TextStyle(fontSize: 20),),
                            ],
                          ),
                          //const Spacer(),
                          IconButton(onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${sepetyemek.yemek_adi} silinsin mi"),
                                  action: SnackBarAction(
                                      label: "Evet",
                                      onPressed: () {
                                        context.read<SepetSayfaCubit>()
                                            .sepettenYemekSil(
                                            int.parse(
                                                sepetyemek.sepet_yemek_id),
                                            kullanici_adi);
                                      }),
                                )
                            );
                          },
                            icon: const Icon(
                                Icons.clear, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
              Row(
                children: [
                  const Spacer(),
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: ElevatedButton(onPressed: (){},
                       style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                       child: Text("Tutar: $toplamTutar",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black),),),
                   ),
                ],
              ),
            ],
          );
          }
          else {
            return const Center();
          }
        }
    ),

    );
  }
}
