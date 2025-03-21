import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/entity/sepet_yemekler.dart';
import 'package:yemek/data/entity/yemekler.dart';
import 'package:yemek/ui/cubit/detaysayfa_cubit.dart';

class Detaysayfa extends StatefulWidget {
  Yemekler yemek;
   Detaysayfa({required this.yemek});

  @override
  State<Detaysayfa> createState() => _DetaysayfaState();
}

class _DetaysayfaState extends State<Detaysayfa> {

  int adet=0;
  String kullanici_adi="faruk";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.yemek.yemek_adi),),
      body: Center(
        child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${widget.yemek.yemek_fiyat} £",style: const TextStyle(fontSize: 50),),
                ElevatedButton(onPressed: (){
                  setState(() {
                    if(adet>0){
                      adet-=1;
                    }
                  });
                }, child: Text("-")),
                Text("$adet"),
                ElevatedButton(onPressed: (){
                  setState(() {
                    adet+=1;
                  });
                }, child: Text("+")),
              ],
            ),

            ElevatedButton(onPressed: (){
              context.read<DetaySayfaCubit>().ekleme(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, int.parse(widget.yemek.yemek_fiyat), adet, kullanici_adi);
            }, child: Text("Sepete Ekle")),

          ],
        ),
      ),
    );
  }
}
