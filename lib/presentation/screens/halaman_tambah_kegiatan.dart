import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kegiatan_mvvm/cubit/tambah_kegiatan_cubit.dart';
import 'package:toast/toast.dart';

class HalamanTambahKegiatan extends StatelessWidget{

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kegiatan"),
      ),
      body: BlocListener<TambahKegiatanCubit, TambahKegiatanState>(
        listener: (context, state) {
          if(state is SelesaiTambahKegiatan){
            Navigator.pop(context);
            return;
          }else if(state is KesalahanTambahKegiatan) {
            Toast.show(state.kesalahan, context, duration: Toast.LENGTH_SHORT, backgroundColor: Colors.red, gravity: Toast.CENTER);
          }
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: _isiHalaman(context),
        ),
      )
    );
  }

  Widget _isiHalaman(context){
    return Column(
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
            BlocProvider.of<TambahKegiatanCubit>(context).tambahKegiatan(namaKegiatan);
          },
          child: _tombolTambah(context)
        )
      ],
    );
  }

  Widget _tombolTambah(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: BlocBuilder<TambahKegiatanCubit, TambahKegiatanState>(
          builder: (context, state) {
            if(state is TambahKegiatan){
              return CircularProgressIndicator(color: Colors.white);
            }
            return Text("Tambah", style: TextStyle(fontSize: 18, color: Colors.white));
          },
        ),
      ),
    );
  }

}