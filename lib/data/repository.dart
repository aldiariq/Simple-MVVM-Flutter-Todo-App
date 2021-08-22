import 'package:flutter_kegiatan_mvvm/constants/strings.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';
import 'package:flutter_kegiatan_mvvm/data/network_service.dart';

class Repository{

  final NetworkService networkService;

  Repository({this.networkService});

  Future<List<Kegiatan>> ambilKegiatan() async {
    final dataKegiatan = await networkService.ambilKegiatan();
    print("repository");
    print(dataKegiatan);
    if(dataKegiatan != null){
      return dataKegiatan.map((e) => Kegiatan.fromJson(e)).toList();
    }else {
      return null;
    }
  }

  Future<bool> ubahStatus(String statusKegiatan, int id) async {
    final dataKegiatan = {
      "statusKegiatan": statusKegiatan
    };

    return await networkService.ubahStatus(dataKegiatan, id);
  }

  Future<Kegiatan> tambahKegiatan(String namaKegiatan) async {
    final dataKegiatan = {
      "namaKegiatan": namaKegiatan,
      "statusKegiatan": KEGIATAN_BELUM_SELESAI
    };

    final datatambahKegiatan = await networkService.tambahKegiatan(dataKegiatan);
    if(datatambahKegiatan == null) return null;

    return Kegiatan.fromJson(datatambahKegiatan);
  }

  Future<bool> hapusKegiatan(int id) async {
    return await networkService.hapusKegiatan(id);
  }

  Future<bool> ubahKegiatan(int id, String namaKegiatan) async {
    final dataKegiatan = {
      "namaKegiatan": namaKegiatan
    };

    return await networkService.ubahKegiatan(dataKegiatan, id);
  }

}