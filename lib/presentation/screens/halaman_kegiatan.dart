import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kegiatan_mvvm/constants/strings.dart';
import 'package:flutter_kegiatan_mvvm/cubit/kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';

class HalamanKegiatan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<KegiatanCubit>(context).ambilKegiatan();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kegiatan"),
        actions: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, HALAMAN_TAMBAH_KEGIATAN_ROUTE),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: BlocBuilder<KegiatanCubit, KegiatanState>(
        builder: (context, state) {
          if(!(state is MuatKegiatan))
            return Center(child: CircularProgressIndicator());
          final dataKegiatan = (state as MuatKegiatan).kegiatans;
          return SingleChildScrollView(
            child: Column(
              children: dataKegiatan.map((e) => _kegiatan(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _kegiatan(Kegiatan kegiatan, context){
    return InkWell(
      onTap: () => Navigator.pushNamed(context, HALAMAN_UBAH_KEGIATAN_ROUTE, arguments: kegiatan),
      child: Dismissible(
          key: Key("${kegiatan.id}"),
          child: _namaKegiatan(kegiatan, context),
          confirmDismiss: (_) async {
            BlocProvider.of<KegiatanCubit>(context).ubahStatus(kegiatan);
            return false;
          },
          background: Container(color: Colors.blueGrey),
      ),
    );
  }

  Widget _namaKegiatan(Kegiatan kegiatan, context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(color: Colors.grey)
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(kegiatan.namaKegiatan),
          _statusKegiatan(kegiatan)
        ],
      ),
    );
  }

  Widget _statusKegiatan(Kegiatan kegiatan){
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          width: 4,
          color: kegiatan.statusKegiatan == "SELESAI" ? Colors.green : Colors.red
        )
      ),
    );
  }
}