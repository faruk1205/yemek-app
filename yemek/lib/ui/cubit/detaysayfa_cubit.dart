import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/repo/yemeklerdao_repository.dart';

class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var krepo = YemeklerDaoRepository();

  Future<void> ekleme(String yemek_adi,String yemek_resim_adi,int yemek_fiyat,int yemek_siparis_adet,String kullanici_adi)async{
    await krepo.ekleme(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}