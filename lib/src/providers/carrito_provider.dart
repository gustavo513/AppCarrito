import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:convert/convert.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:client/src/pages/home_page.dart';
import 'package:client/src/models/carrito_model.dart';

class CarritoProvider{

  final _dio = Dio();

  final String _urlBase = 'http://${dotenv.env['IP']}:5000/carrito';

  Future<int> guardarCarrito(Carrito carrito) async{

    final url = '$_urlBase/agregar';

    try{

      final respuesta = await _dio.post(url, data: {
        "estado"        :   "N",
        "id_usuario"    :   carrito.id_usuario,
        "detalle"       :   carrito.detalle!.map((d) => d.toJson()).toList(),
      });

      return respuesta.statusCode!;

    }
    catch(error){
      return 0;
    }

  }

  Future<int> leerNotificacion(int? id_carrito) async{
    
    final url = '$_urlBase/leer_notificacion';

    try{
      final respuesta = await _dio.post(url, data: {
        "id_carrito"  :   id_carrito
      });

      return respuesta.data["notificacion"];
    }
    catch(error){
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> listarCarritosPorEstado(String estado) async{

    List<Map<String, dynamic>> lista = [];

    Map<String, dynamic> detalles;

    final url = '$_urlBase/carritos_por_estado';

    try{
      final respuesta = await _dio.get(url, data: {
        "id_usuario": idUsuario,
        "estado": estado
      });

      respuesta.data.forEach((elemento){
        
        detalles = {
          "id_carrito"      :   elemento["id_carrito"],
          "fecha_carrito"   :   '${DateTime.parse(elemento["fecha_carrito"]).day}-${DateTime.parse(elemento["fecha_carrito"]).month}-${DateTime.parse(elemento["fecha_carrito"]).year}',
          "estado_carrito"  :   elemento["estado_carrito"]
        };

        lista.add(detalles);
      });

      return lista;
    }
    catch(error){
      throw FormatException('Error al listar carritos pendientes');
    }
  }


}