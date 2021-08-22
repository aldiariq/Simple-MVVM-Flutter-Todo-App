part of 'tambah_kegiatan_cubit.dart';

@immutable
abstract class TambahKegiatanState {}

class TambahKegiatanInitial extends TambahKegiatanState {}

class KesalahanTambahKegiatan extends TambahKegiatanState{
  final String kesalahan;
  KesalahanTambahKegiatan({this.kesalahan});
}

class TambahKegiatan extends TambahKegiatanState{}
class SelesaiTambahKegiatan extends TambahKegiatanState{}