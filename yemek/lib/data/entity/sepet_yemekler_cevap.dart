import 'package:yemek/data/entity/sepet_yemekler.dart';

class SepetYemeklerCevap{
  List<SepetYemekler> sepetYemekler;
  int success;

  SepetYemeklerCevap({required this.sepetYemekler, required this.success});

  factory SepetYemeklerCevap.fromJson(Map<String,dynamic> json){

    var jsonArray = json["sepet_yemekler"] as List;
    int success = json["success"] as int ;

    var sepetYemekler = jsonArray.map((jsonArrayNesnesi)=> SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(sepetYemekler: sepetYemekler, success: success);

  }
}