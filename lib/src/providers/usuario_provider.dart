import 'package:dio/dio.dart' as dio;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:client/src/models/usuario_model.dart';

class UsuarioProvider{

  final _dio = dio.Dio();

  final String url = 'http://${dotenv.env['IP']}:5000/usuario';

  Future<UsuarioModel> obtenerUsuario(int id) async{
    final dynamic datos = await _dio.get(
      '$url/obtener_usuario',
      data: {
        "id_usuario": id
      }
    );

    final UsuarioModel usuario = new UsuarioModel(
                                          nombre    : datos["usuario"][0], 
                                          apellido  : datos["usuario"][1], 
                                          correo    : datos["usuario"][2], 
                                          username  : datos["usuario"][3], 
                                          password  : datos["usuario"][4]
    );

    return usuario;
  }

  Future<dynamic> actualizarUsuario(UsuarioModel usuario) async{

      final respuesta = await _dio.put(
        '$url/actualizar_usuario',
        data: {
          "id_usuario"      : usuario.id,
          "nombre"          : usuario.nombre,
          "apellido"        : usuario.apellido,
          "correo"          : usuario.correo,
          "username"        : usuario.username,
          "token_firebase"  : usuario.tokenFirebase
        }
      );

      return respuesta;
  }

  Future<dynamic> actualizarTokenFirebase({required String token, required int id}) async {

  final dynamic usuario = await _dio.patch(
      '$url/actualizar_token_firebase',
      data: {
        "id_usuario": id,
        "token_firebase": token
      }
  );

  }
}

