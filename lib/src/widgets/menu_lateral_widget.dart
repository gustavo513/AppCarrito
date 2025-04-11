import 'package:client/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class MenuLateralWidget extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () => Navigator.of(context).popAndPushNamed('/home')
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil')
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Carrito'),
              onTap: () => Navigator.of(context).popAndPushNamed('/carrito'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Clientes'),
              onTap: () => Navigator.of(context).popAndPushNamed('/cliente'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Cerrar sesión'),
              onTap: () {
                idUsuario = null;
                Navigator.of(context).pushNamedAndRemoveUntil('/', (ruta) => false);
              }
            ),
            Divider(),
          ],
        ),
      );
  }
}