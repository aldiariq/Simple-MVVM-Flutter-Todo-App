import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kegiatan_mvvm/constants/strings.dart';
import 'package:flutter_kegiatan_mvvm/data/model/kegiatan.dart';
import 'package:flutter_kegiatan_mvvm/data/network_service.dart';
import 'package:flutter_kegiatan_mvvm/data/repository.dart';
import 'package:flutter_kegiatan_mvvm/presentation/screens/halaman_kegiatan.dart';
import 'package:flutter_kegiatan_mvvm/presentation/screens/halaman_tambah_kegiatan.dart';
import 'package:flutter_kegiatan_mvvm/presentation/screens/halaman_ubah_kegiatan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kegiatan_mvvm/cubit/kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/cubit/tambah_kegiatan_cubit.dart';
import 'package:flutter_kegiatan_mvvm/cubit/ubah_kegiatan_cubit.dart';

class RouteApp {

  Repository repository;
  KegiatanCubit kegiatanCubit;


  RouteApp(){
    repository = Repository(networkService: NetworkService());
    kegiatanCubit = KegiatanCubit(repository: repository);
  }

  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HALAMAN_UTAMA_ROUTE:
        return MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: kegiatanCubit,
            child: HalamanKegiatan()
        ));
      case HALAMAN_TAMBAH_KEGIATAN_ROUTE:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext buildContext) => TambahKegiatanCubit(repository: repository, kegiatanCubit: kegiatanCubit),
              child: HalamanTambahKegiatan(),
            ),
        );
      case HALAMAN_UBAH_KEGIATAN_ROUTE:
        final dataKegiatan = routeSettings.arguments as Kegiatan;

        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext buildContext) => UbahKegiatanCubit(repository: repository, kegiatanCubit: kegiatanCubit),
              child: HalamanUbahKegiatan(kegiatan: dataKegiatan),
            ),
        );
      default:
        return null;
    }
  }
}