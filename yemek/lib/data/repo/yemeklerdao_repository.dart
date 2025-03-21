import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:yemek/data/entity/sepet_yemekler.dart';
import 'package:yemek/data/entity/sepet_yemekler_cevap.dart';
import 'package:yemek/data/entity/yemekler.dart';
import 'package:yemek/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository {

  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap
        .fromJson(json.decode(cevap))
        .yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap){
    return SepetYemeklerCevap
        .fromJson(json.decode(cevap))
        .sepetYemekler;
  }


  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<List<SepetYemekler>> sepetYemeklerYukle(String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri ={"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data:FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }


  Future<void> ekleme(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,kullanici_adi)async{
    var url= "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri={"yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Kişi kaydet : ${cevap.data.toString()}");
  }

  Future<void> sepettenYemekSil(int sepet_yemek_id,String kullanici_adi)async{
    var url= "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri ={"sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Kişi Sil : ${cevap.data.toString()}");
  }

}