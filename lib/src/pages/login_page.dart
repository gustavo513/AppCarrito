import 'package:client/src/models/usuario_model.dart';
import 'package:client/src/pages/home_page.dart';
import 'package:client/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

import 'package:client/src/widgets/fondo_aut_widget.dart';
import 'package:client/src/models/auth_model.dart';
import 'package:client/src/providers/auth_provider.dart';
import 'package:client/src/widgets/cuadro_error_widget.dart';

class LoginPage extends StatelessWidget{

  final double _altura = 0.92;
  final String _rutaImagen = 'assets/hilagro.jpg';
  final String _encabezado = 'Inicio de sesión';

  final TextEditingController correoUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthProvider auth = new AuthProvider();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 244, 244),
      body: FondoAutWidget(
                //context: context, 
                altura: _altura, 
                rutaImagen: _rutaImagen, 
                encabezado: _encabezado, 
                campos: _crearCampos(), 
                separacionCampos: 20.0,
                textoBoton: 'Iniciar sesión',
                accionBoton: _iniciarSesion,
                piePagina: _crearPiePagina(context),
      )
    );
  }

  List<Widget> _crearCampos(){
    return [
        TextField(
          controller: correoUsernameController,
          decoration: InputDecoration(
            label: Text('Correo o nombre de usuario'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
          ),
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            label: Text('Contraseña'),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
          ),
        )
    ];
  }

  Widget _crearPiePagina(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('¿Todavía no tienes una cuenta?'),
        TextButton(
          onPressed: (){
            Navigator.of(context).pushNamed('/registro');
          },
          child: Text('Registrarse'),
        )
      ],
    );
  }

  Future<void> _iniciarSesion(BuildContext context) async{
    idUsuario = null;

    final usuario = new AuthModel(
      correoUsernameController.text,
      correoUsernameController.text,
      passwordController.text
    );

    final respuesta = await auth.autenticacion(usuario);

    if(respuesta['respuesta'] == 1){
      idUsuario = respuesta['id_usuario'];
      await Navigator.of(context).pushNamed('/home');
      correoUsernameController.text = '';
      correoUsernameController.text = '';
      passwordController.text = '';
      print('Correo: $correoUsernameController - ID: $idUsuario');
      return;
    }
   
    return crearMensajeError(
      context: context, 
      titulo: 'credenciales', 
      mensaje: 'Por favor, verifique sus credenciales e intente nuevamente.'
    );
  }

}