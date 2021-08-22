import 'dart:convert';

import 'package:http/http.dart';

class NetworkService{

  final baseUrl = "http://192.168.100.8:3000";

  Future<List<dynamic>> ambilKegiatan() async {
    try{
      final response = await get(Uri.parse(baseUrl + "/kegiatan"));
      return jsonDecode(response.body) as List;
    }catch(e){
      return [];
    }
  }

  Future<bool> ubahStatus(Map<String, String> dataKegiatan, int id) async {
    try{
      patch(Uri.parse(baseUrl + "/kegiatan/$id"), body: dataKegiatan);
      return true;
    }catch(e){
      return false;
    }
  }

  Future<Map> tambahKegiatan(Map<String, String> dataKegiatan) async {
    try{
      final response = await post(Uri.parse(baseUrl + "/kegiatan"), body: dataKegiatan);
      return jsonDecode(response.body);
    }catch(e){
      return null;
    }
  }

  Future<bool> hapusKegiatan(int id) async {
    try{
      delete(Uri.parse(baseUrl + "/kegiatan/$id"));
      return true;
    }catch(e){
      return false;
    }
  }

  Future<bool> ubahKegiatan(Map<String, String> dataKegiatan, int id) async {
    try{
      patch(Uri.parse(baseUrl + "/kegiatan/$id"), body: dataKegiatan);
      return true;
    }catch(e){
      return false;
    }
  }
}