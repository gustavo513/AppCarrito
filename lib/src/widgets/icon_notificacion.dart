import 'package:flutter/material.dart';

class IconNotificacion extends StatefulWidget{

  int _cantidadNotif = 0;

  IconNotificacionState createState() => IconNotificacionState();
}

class IconNotificacionState extends State<IconNotificacion>{

  initState(){
    super.initState();
  }

  Widget build(BuildContext context){
    return Stack(
      textDirection: TextDirection.rtl,
      children: [
        Text('${widget._cantidadNotif}'),
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.notifications),
        ),
      ]
    );
  }
}