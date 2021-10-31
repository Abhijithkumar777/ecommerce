
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intertoon/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Intertoon',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      
      home: Home(),

      
    );
  }

}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
