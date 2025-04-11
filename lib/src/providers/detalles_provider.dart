import 'package:dio/dio.dart';

import 'package:client/src/models/detalle_model.dart';

class DetallesProvider{

  final Dio _dio = new Dio();

  final _urlBase = 'http://192.168.0.31:5000/detalles';

  Future<List<DetalleModel>> obtenerDetalles(int id_carrito) async{

    List<DetalleModel> lista = [];

    final url = '$_urlBase/listar_detalles';

    final respuesta = await _dio.get(
      url,
      data: {
        "id_carrito": id_carrito
      }
    );

    respuesta.data.forEach((elemento) {
      DetalleModel detalle = new DetalleModel(
        id_producto         :     elemento["id_producto"],
        cantidad            :     elemento["cant_prod"],
        monto_total         :     elemento["monto_total"],
        precio_unitario     :     elemento["precio_unit"]  
      );

      lista.add(detalle);
    });

    return lista;

  }
}
