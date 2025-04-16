import 'package:client/src/widgets/fondo_aut_widget.dart';
import 'package:client/src/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            leading: Image(
                  image: AssetImage('assets/hilagro_logo_blanco.png')
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 46, 73, 159),
      ),
      endDrawer: MenuLateralWidget(),
      body: Text('Perfil')
    );
  }
  
}