import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_kegiatan_mvvm/constants/strings.dart';
import 'package:flutter_kegiatan_mvvm/data/repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';

part 'kegiatan_state.dart';

class KegiatanCubit extends Cubit<KegiatanState> {
  final Repository repository;

  KegiatanCubit({this.repository}) : super(KegiatanInitial());

  void ambilKegiatan() {
    Timer(Duration(seconds: 3), (){
      repository.ambilKegiatan().then((kegiatan) {
        emit(MuatKegiatan(kegiatans: kegiatan));
      });
    });
  }

  void ubahStatus(Kegiatan kegiatan) {
    String statusKegiatan = "";
    if(kegiatan.statusKegiatan == "SELESAI"){
      statusKegiatan = KEGIATAN_BELUM_SELESAI;
    }else {
      statusKegiatan = KEGIATAN_SELESAI;
    }
    repository.ubahStatus(statusKegiatan, kegiatan.id).then((berhasilMerubah){
      if(berhasilMerubah){
        kegiatan.statusKegiatan = statusKegiatan;
        ubahState();
      }
    });
  }

  void ubahState() {
    final stateSekarang = state;
    if(stateSekarang is MuatKegiatan){
      emit(MuatKegiatan(kegiatans: stateSekarang.kegiatans));
    }
  }

  void tambahData(Kegiatan kegiatan) {
    final stateSekarang = state;
    if(stateSekarang is MuatKegiatan){
      final listKegiatan = stateSekarang.kegiatans;
      listKegiatan.add(kegiatan);
      emit(MuatKegiatan(kegiatans: listKegiatan));
    }
  }

  void hapusKegiatan(Kegiatan kegiatan) {
    final stateSekarang = state;
    if(stateSekarang is MuatKegiatan){
      final listKegiatan = stateSekarang.kegiatans.where((element) => element.id != kegiatan.id).toList();
      emit(MuatKegiatan(kegiatans: listKegiatan));
    }
  }

  void ubahKegiatan(){
    final stateSekarang = state;
    if(stateSekarang is MuatKegiatan){
      final listKegiatan = stateSekarang.kegiatans;
      emit(MuatKegiatan(kegiatans: listKegiatan));
    }
  }
}
