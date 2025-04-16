import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart' as dio;

import 'package:client/src/models/auth_model.dart';
import 'package:client/src/models/usuario_model.dart';

class AuthProvider{

    final _dio = dio.Dio();

    final _urlBase = 'http://${dotenv.env['IP']}:5000/autenticacion';
  
    Future<Map<String, dynamic>> registro(UsuarioModel usuario) async{

        final url = '${_urlBase}/registro';
        
        dynamic? respuesta;
        
        try{
            respuesta = await _dio.post(url, data: {
                'nombre'    :   usuario.nombre,
                'apellido'  :   usuario.apellido,
                'correo'    :   usuario.correo,
                'username'  :   usuario.username,
                'password'  :   usuario.password,
            });

            return respuesta.data;

        } 
        catch(error){
          return respuesta.statusCode;
        }
    }

    Future<Map<String, dynamic>> autenticacion(AuthModel auth) async{
      
      final url = '${_urlBase}/';

      final respuesta = await _dio.post(url, data: {
        'correo'      :   auth.correo,
        'username'    :   auth.username,
        'password'    :   auth.password,
      });

      return respuesta.data;
    }
}