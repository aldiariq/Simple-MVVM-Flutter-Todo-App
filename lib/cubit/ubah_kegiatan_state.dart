part of 'ubah_kegiatan_cubit.dart';

@immutable
abstract class UbahKegiatanState {}

class UbahKegiatanInitial extends UbahKegiatanState {}
class KesalahanUbahKegiatan extends UbahKegiatanState{
  final String kesalahan;
  KesalahanUbahKegiatan({this.kesalahan});
}

class SelesaiUbahKegiatan extends UbahKegiatanState{

}
