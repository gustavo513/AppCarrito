import 'package:client/src/pages/home_page.dart';
import 'package:client/src/providers/notificacion_provider.dart';
import 'package:flutter/material.dart';

import 'package:client/src/providers/auth_provider.dart';
import 'package:client/src/widgets/fondo_aut_widget.dart';
import 'package:client/src/models/usuario_model.dart';
import 'package:client/src/widgets/cuadro_confirmacion_widget.dart';

//depuracion, borrar despues
import 'package:client/src/providers/usuario_provider.dart';

class RegistroPage extends StatelessWidget{

  final double _altura = 1.20;
  final String _rutaImagen = 'assets/hilagro.jpg';
  final String _encabezado = 'Registro';


  AuthProvider auth = new AuthProvider();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordSecondController = TextEditingController();

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 244, 244),
        body: FondoAutWidget( 
                altura            :    _altura,
                rutaImagen        :    _rutaImagen,
                activarLogo       :    true,
                encabezado        :     _encabezado,
                campos            :     _crearCampos(), 
                separacionCampos  :     20.0, 
                textoBoton        :     'Registrarse',
                accionBoton       :     _registrarUsuario,
                piePagina         :     _crearPiePagina(context)
      )
    );
  }

  List<Widget> _crearCampos(){
    String mensaje = '';

    return [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  label: Text('Nombre'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              ),
              TextField(
                controller: apellidoController,
                decoration: InputDecoration(
                  label: Text('Apellido'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                )
              ),
              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  label: Text('Correo electrónico'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  label: Text('Nombre de usuario'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                decoration: InputDecoration(
                  label: Text('Contraseña'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ),
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordSecondController,
                decoration: InputDecoration(
                  label: Text('Repita la contraseña'),
                  counterText: mensaje,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                onChanged: (String passwordSegundo){
                  if(passwordSegundo == passwordController.text){
                    mensaje = 'Las contraseñas coinciden';
                  }
                  else{
                    mensaje = 'Las contraseñas no coinciden';
                  }
                }
              ),
        ];
  }

  Widget _crearPiePagina(BuildContext context){
    return IconButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/');
            },
            icon: Icon(Icons.keyboard_double_arrow_left),
    );
  }

  Future<void> _registrarUsuario (BuildContext context) async{

    final usuario = new UsuarioModel(
        nombre          :   nombreController.text,
        apellido        :   apellidoController.text,
        correo          :   correoController.text,
        username        :   usernameController.text,
        password        :   passwordController.text
    );

    final respuesta = await auth.registro(usuario);

    usuario.id = respuesta['idUsuario'];

        //depuración, borrar después
    UsuarioProvider usuarioProv = new UsuarioProvider();

    print(await usuarioProv.actualizarUsuario(new UsuarioModel(id: usuario.id, nombre: usuario.nombre!, apellido: "usuario de prueba", correo: usuario.correo!, username: usuario.username!, password: usuario.password!)));

    if(respuesta['respuesta'] == 1){
      nombreController.text           =   '';
      apellidoController.text         =   '';
      correoController.text           =   '';
      usernameController.text         =   '';
      passwordController.text         =   '';
      passwordSecondController.text   =   '';
      idUsuario                       =   respuesta['idUsuario'];
      return crearMensajeConfirmacion(context: context, mensaje: 'Registro exitoso');
    }

  }
}

