import 'package:client/src/widgets/cuadro_notificacion.dart';
import 'package:flutter/material.dart';
import 'package:client/src/widgets/cuadro_confirmacion_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificacionProvider{

  String? _token;

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> initNotificacion() async {

    _firebaseMessaging.requestPermission(provisional: true);

    _token = await _firebaseMessaging.getToken(); 

    return _token!;
  }

  notificacionPrimerPlano(BuildContext context){
    FirebaseMessaging.onMessage.listen((RemoteMessage mensaje){

      print('Mensaje: ${mensaje.data}');

      crearMensajeNotificacion(context: context, titulo: mensaje.data["title"], mensaje: mensaje.data["body"]);

      if(mensaje.notification != null){
        print('El mensaje también contiene una notificación: ${mensaje.notification}');
      }
    });
  }

}