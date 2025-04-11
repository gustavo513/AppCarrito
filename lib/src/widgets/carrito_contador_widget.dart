import 'package:flutter/material.dart';

import 'package:client/src/pages/home_page.dart';

class CarritoContadorWidget extends StatefulWidget{

  State<CarritoContadorWidget> createState() => CarritoContadorState();

}

class CarritoContadorState extends State<CarritoContadorWidget>{

  @override
  initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
   return Stack(
    textDirection: TextDirection.rtl,
    children: [
      Text('${carrito!.detalle!.length}', style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),
      IconButton(
        padding: EdgeInsets.all(18.0),
        onPressed: (){
          Navigator.of(context).pushNamed('/carrito');
        },
        icon: Icon(Icons.shopping_cart, size: 40.0, color: Colors.blue),
      ),
    ],
   ); 
  }

  void cambiarContador(){
    setState(() {
      
    });
  }

}