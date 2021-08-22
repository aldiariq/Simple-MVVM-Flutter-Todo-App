part of 'kegiatan_cubit.dart';

@immutable
abstract class KegiatanState {}

class KegiatanInitial extends KegiatanState {}

class MuatKegiatan extends KegiatanState {
  final List<Kegiatan> kegiatans;

  MuatKegiatan({this.kegiatans});
}
