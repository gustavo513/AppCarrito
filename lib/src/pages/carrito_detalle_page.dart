import 'package:flutter/material.dart';

import 'package:client/src/pages/home_page.dart';
import 'package:client/src/providers/carrito_provider.dart';
import 'package:client/src/widgets/tabla_detalles_widget.dart';
import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/widgets/cuadro_error_widget.dart';

/* 
  Este widget crea la página para visualizar los productos agregados al carrito actual (aún sin enviar)
*/

class CarritoDetallePage extends StatefulWidget{

  State<CarritoDetallePage> createState() => _CarritoDetalleState();

}

class _CarritoDetalleState extends State<CarritoDetallePage>{

  final CarritoProvider carritoProvider = new CarritoProvider();

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _crearBotones(),
            TablaDetallesWidget(),
            Text('Total: ${_calcularTotalCarrito()}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),)
          ]
        ),
      );
  }

   Widget _crearBotones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green
          ),
          onPressed: () async{
            if(carrito!.detalle!.isEmpty){
              crearMensajeError(context: context, titulo: 'carrito vacío', mensaje: 'Por favor, agregue productos al carrito.');
            }
            else{
              await carritoProvider.guardarCarrito(carrito!);
            }
            setState(() {
              carrito = new Carrito(id_usuario: idUsuario, detalle: []);
            });
          },
          child: Text('Confirmar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
        SizedBox(width: 10.0,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: (){
            setState(() {
              carrito = null;
              carrito = new Carrito(id_usuario: idUsuario, detalle: []);
            });
          },
          child: Text('Restablecer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
      ],
    );
  }

  int _calcularTotalCarrito(){
    int suma = 0;
    for(var item in carrito!.detalle!){
      suma = suma + item.monto_total!;
    }

    return suma;
  }

}