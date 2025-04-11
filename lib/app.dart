import 'package:flutter/material.dart';

import 'package:client/src/routes/routes.dart';

class App extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      //theme: ,
      title: 'Autenticacion',
      initialRoute: '/',
      routes: getRoutes(context),
      debugShowCheckedModeBanner: false,
    );
  }
}