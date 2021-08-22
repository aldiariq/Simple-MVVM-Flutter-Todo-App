// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_kegiatan_mvvm/presentation/routeApp.dart';
import 'package:flutter_kegiatan_mvvm/presentation/screens/halaman_kegiatan.dart';

void main(){
  runApp(KegiatanApp(
    routeApp: RouteApp(),
  ));
}

class KegiatanApp extends StatelessWidget{

  final RouteApp routeApp;

  const KegiatanApp({Key key, this.routeApp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: routeApp.generateRoute,
    );
  }
}