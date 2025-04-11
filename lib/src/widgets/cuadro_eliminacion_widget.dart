import 'package:flutter/material.dart';
import 'dart:async';

Future<int> confirmarEliminacion({required BuildContext context, required String titulo, required String mensaje}) async {

  int? respuesta;

  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        
        title: Text('$titulo'),
        content: Text('$mensaje'),
        actions: [
          TextButton(
            onPressed: () async{
              respuesta = await _asingarValor(1);
              Navigator.of(context).pop();
            },
            child: Text('Eliminar') 
          ),
          TextButton(
            onPressed: () async{
              respuesta = await _asingarValor(0);
              Navigator.of(context).pop();
            },
            child: Text('Cancelar')
          ),
        ]
      );
    }
  );

  return respuesta!;
  
}

Future<int> _asingarValor(int valor) async{
    return valor;
}