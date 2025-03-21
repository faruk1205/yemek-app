import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/entity/sepet_yemekler.dart';
import 'package:yemek/data/repo/yemeklerdao_repository.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit(): super(<SepetYemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> sepetYemeklerYukle(String kullanici_adi) async{
   var liste = await krepo.sepetYemeklerYukle(kullanici_adi);
   emit(liste);
  }
  Future<void> sepettenYemekSil(int sepet_yemek_id,String kullanici_adi)async{
    await krepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepetYemeklerYukle(kullanici_adi);
  }
}