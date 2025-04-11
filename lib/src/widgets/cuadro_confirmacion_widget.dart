import 'package:flutter/material.dart';

Future<void> crearMensajeConfirmacion({BuildContext? context, required String mensaje}) async {
  return showDialog(
    barrierDismissible: true,
    context: context!,
    builder: (context) {
      return AlertDialog(
        title: Text('Confirmación'),
        content: Text('$mensaje'),
        actions: [
          ElevatedButton.icon(
            onPressed: (){
              Navigator.of(context).pop(); //cierra el cuadro de dialogo
              Navigator.of(context).pushNamed('/home');
            },
            icon: Icon(Icons.arrow_right),
            label: Text('Continuar...')
          ),
        ],
      );
    }
  );
}