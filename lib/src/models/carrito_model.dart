import 'package:client/src/models/detalle_model.dart';

class Carrito{

  int? id_carrito;
  int? estado;
  DateTime? fecha;
  int? id_usuario;
  List<DetalleModel>? detalle;

  Carrito({this.id_carrito, this.estado, this.fecha, this.id_usuario, this.detalle});

}