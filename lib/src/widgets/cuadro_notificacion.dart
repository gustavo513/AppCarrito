import 'package:client/src/providers/carrito_provider.dart';
import 'package:flutter/material.dart';

Future<void> crearMensajeNotificacion({required BuildContext context, required String titulo, required String mensaje}){

  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        icon: Icon(Icons.check, color: Colors.green),
        title: Text('Notificación', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('$mensaje'),
        actions: [
          TextButton(
            onPressed: () async{
              CarritoProvider carrito = new CarritoProvider();
              final respuesta = await carrito.leerNotificacion(int.parse(titulo));

              if(respuesta == 1){
                Navigator.of(context).pop();
              }
            },
            child: Text('Marcar como leído'),
          ),
        ]
      );
    }
  );
}