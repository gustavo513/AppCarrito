import 'package:convert/convert.dart';

class UsuarioModel{

  int? id;
  String? nombre;
  String? apellido;
  String? correo;
  String? username;
  String? password;
  String? tokenFirebase;

  UsuarioModel({int? id, required String nombre, required String apellido, required String correo, required String username, required String password, String? tokenFirebase = ''}){
    this.id             =  id;
    this.nombre         =  nombre;
    this.apellido       =  apellido;
    this.correo         =  correo;
    this.username       =  username;
    this.password       =   password;
    this.tokenFirebase  =   tokenFirebase;
  }

  Map<String, dynamic> toJson(json){
    return {"nombre": "Gustavo"};
  }

}