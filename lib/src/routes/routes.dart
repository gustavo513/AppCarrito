import 'package:flutter/material.dart';

import 'package:client/src/pages/registro_page.dart';
import 'package:client/src/pages/login_page.dart';
import 'package:client/src/pages/home_page.dart';
import 'package:client/src/pages/carrito_page.dart';
import 'package:client/src/pages/cliente_page.dart';
import 'package:client/src/pages/perfil_page.dart';


Map<String, WidgetBuilder> getRoutes(BuildContext context){
  return <String, WidgetBuilder>{
    '/'                     :     (context) => LoginPage(),
    '/registro'             :     (context) => RegistroPage(),
    '/home'                 :     (context) => HomePage(),
    '/cliente'              :     (context) => ClientePage(),
    '/carrito'              :     (context) => CarritoPage(),
    '/perfil'               :     (context) => PerfilPage(),
  };
}