import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek/data/entity/yemekler.dart';
import 'package:yemek/data/repo/yemeklerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);


  var krepo = YemeklerDaoRepository();


  Future<void> yemekleriYukle() async {
    var liste = await krepo.yemekleriYukle();
    emit(liste);
  }
}