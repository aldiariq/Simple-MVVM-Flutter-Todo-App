import 'package:bloc/bloc.dart';
import 'package:flutter_kegiatan_mvvm/cubit/kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';
import 'package:flutter_kegiatan_mvvm/data/repository.dart';
import 'package:meta/meta.dart';

part 'ubah_kegiatan_state.dart';

class UbahKegiatanCubit extends Cubit<UbahKegiatanState> {
  final Repository repository;
  final KegiatanCubit kegiatanCubit;

  UbahKegiatanCubit({this.repository, this.kegiatanCubit}) : super(UbahKegiatanInitial());

  void hapusKegiatan(Kegiatan kegiatan) {
    repository.hapusKegiatan(kegiatan.id).then((statusHapus){
      if(statusHapus != null){
        kegiatanCubit.hapusKegiatan(kegiatan);
        emit(SelesaiUbahKegiatan());
      }else {
        emit(KesalahanUbahKegiatan(kesalahan: "Gagal Mengubah Kegiatan"));
      }
    });
  }

  void ubahKegiatan(Kegiatan kegiatan, String namaKegiatan) {
    if(namaKegiatan.isEmpty){
      emit(KesalahanUbahKegiatan(kesalahan: "Pastikan Inputan Terisi"));
      return;
    }else {
      repository.ubahKegiatan(kegiatan.id, namaKegiatan).then((statusUbah){
        if(statusUbah){
          kegiatan.namaKegiatan = namaKegiatan;
          kegiatanCubit.ubahKegiatan();
          emit(SelesaiUbahKegiatan());
        }else {
          emit(KesalahanUbahKegiatan(kesalahan: "Gagal Mengubah Kegiatan"));
          return;
        }
      });
    }
  }


}
