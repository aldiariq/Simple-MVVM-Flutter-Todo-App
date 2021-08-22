class Kegiatan {
  String namaKegiatan;
  String statusKegiatan;
  int id;

  Kegiatan.fromJson(Map json) : namaKegiatan = json["namaKegiatan"],
        statusKegiatan = json["statusKegiatan"],
        id = json["id"] as int;


}