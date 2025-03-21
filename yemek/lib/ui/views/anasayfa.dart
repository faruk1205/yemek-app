import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/entity/yemekler.dart';
import 'package:yemek/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek/ui/cubit/detaysayfa_cubit.dart';
import 'package:yemek/ui/views/detaysayfa.dart';
import 'package:yemek/ui/views/sepetsayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  int adet=0;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(title: Text("Yemek",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),backgroundColor:Colors.red,centerTitle: true,),
      body: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(
              itemCount: yemeklerListesi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,childAspectRatio: 1/1.8
              ),
              itemBuilder: (context,indeks){
                var yemek = yemeklerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Detaysayfa(yemek:yemek))); // bakılacak!!!!!!
                  },
                  child: Card(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                        Text("${yemek.yemek_adi}",style: TextStyle(fontSize: 20),),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("${yemek.yemek_fiyat} £ ",style: const TextStyle(fontSize: 24),),


                          ],
                        ),
                      ],
                      
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Sepetsayfa()));

            },child:Icon(Icons.shopping_basket_outlined) ,),


    );
  }
}
