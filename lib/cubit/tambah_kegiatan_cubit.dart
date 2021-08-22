import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_kegiatan_mvvm/cubit/kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/data/repository.dart';
import 'package:meta/meta.dart';

part 'tambah_kegiatan_state.dart';

class TambahKegiatanCubit extends Cubit<TambahKegiatanState> {
  final Repository repository;
  final KegiatanCubit kegiatanCubit;

  TambahKegiatanCubit({this.repository, this.kegiatanCubit}) : super(TambahKegiatanInitial());

  void tambahKegiatan(String namaKegiatan) {
    if(namaKegiatan.isEmpty){
      emit(KesalahanTambahKegiatan(kesalahan: "Pastikan Inputan Terisi"));
      return;
    }

    emit(TambahKegiatan());
    Timer(Duration(seconds: 5), (){
      repository.tambahKegiatan(namaKegiatan).then((kegiatan) {
        if(kegiatan != null){
          kegiatanCubit.tambahData(kegiatan);
          emit(SelesaiTambahKegiatan());
        }else {
          emit(KesalahanTambahKegiatan(kesalahan: "Gagal Menambah Kegiatan"));
        }
      });
    });
  }
}
