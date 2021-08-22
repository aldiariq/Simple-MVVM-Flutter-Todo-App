import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kegiatan_mvvm/cubit/ubah_kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';
import 'package:toast/toast.dart';

class HalamanUbahKegiatan extends StatelessWidget{

  final Kegiatan kegiatan;
  HalamanUbahKegiatan({Key key, this.kegiatan}) : super(key: key);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    _controller.text = kegiatan.namaKegiatan;

    return BlocListener<UbahKegiatanCubit, UbahKegiatanState>(
      listener: (context, state) {
        if(state is SelesaiUbahKegiatan){
          Navigator.pop(context);
          return;
        }else if(state is KesalahanUbahKegiatan) {
          Toast.show(state.kesalahan, context, duration: Toast.LENGTH_SHORT, backgroundColor: Colors.red, gravity: Toast.CENTER);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Ubah Kegiatan"),
            actions: [
              InkWell(
                onTap: (){
                  BlocProvider.of<UbahKegiatanCubit>(context).hapusKegiatan(kegiatan);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.delete),
                ),
              )
            ],
          ),
          body: _isiHalaman(context)
      ),
    );
  }

  Widget _isiHalaman(context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(hintText: "Nama Kegiatan"),
          ),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                final namaKegiatan = _controller.text;
                BlocProvider.of<UbahKegiatanCubit>(context).ubahKegiatan(kegiatan, namaKegiatan);
              },
              child: _tombolUbah(context)
          )
        ],
      ),
    );
  }

  Widget _tombolUbah(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text("Simpan", style: TextStyle(fontSize: 18, color: Colors.white),),
      ),
    );
  }

}