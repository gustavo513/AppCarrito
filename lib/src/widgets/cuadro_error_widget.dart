import 'package:flutter/material.dart';

Future<void> crearMensajeError({required BuildContext context, required String titulo, required String mensaje}){

  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Error de $titulo', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('$mensaje'),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Center(child: Text('Aceptar')),
            ),
          ]
        );
      }
    );

}