import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/models/detalle_model.dart';
import 'package:client/src/pages/home_page.dart';
import 'package:client/src/widgets/carrito_contador_widget.dart';
import 'package:flutter/material.dart';

/* 
  Este widget crea un botón de carrito por cada producto. Permite agregar una cierta cantidad de un producto al carrito.
*/

class CarritoWidget extends StatefulWidget{

  int _cantidad = 1;

  Carrito? _carrito;

  DetalleModel? _detalle;

  CarritoWidget({required DetalleModel detalle}){
    this._detalle = new DetalleModel(
                              id_producto: detalle.id_producto!,
                              precio_unitario: detalle.precio_unitario!,
                        );
  }

  State<CarritoWidget> createState() => CarritoWidgetState();

}

class CarritoWidgetState extends State<CarritoWidget>{

  @override
  Widget build(BuildContext context){
    return Container(
              margin: EdgeInsets.only(top: 5.0),
              height: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                color: Color.fromARGB(255, 46, 73, 159),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      _disminuirCantidad();
                    },
                    icon: Icon(Icons.remove, color: Colors.white,)
                  ),
                  SizedBox(width: 2.0,),
                  Text('${widget._cantidad}', style: TextStyle(color: Colors.white)),
                  SizedBox(width: 2.0,),
                  IconButton(
                    onPressed: (){
                      _aumentarCantidad();
                    },
                    icon: Icon(Icons.add, color: Colors.white,)
                  ),
                  SizedBox(width: 2.0,),
                  IconButton(
                    hoverColor: Colors.amber,
                    tooltip: 'Agregado',
                    onPressed: (){
                      _agregarProducto(widget._detalle!);
                    },
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                  )
                ],
              ),
            );
  }

  void _aumentarCantidad(){
    setState((){
      widget._cantidad++;
    });
  }

  void _disminuirCantidad(){
    setState((){
      if(widget._cantidad > 1){
        widget._cantidad--;
      }
    });
  }

  void _agregarProducto(DetalleModel detalle){

      int sw = 0;

      for(int indice = 0; indice < carrito!.detalle!.length; indice++){

        if(detalle.id_producto == carrito!.detalle![indice].id_producto){
            carrito!.detalle![indice].cantidad = carrito!.detalle![indice].cantidad! + widget._cantidad;
            carrito!.detalle![indice].monto_total = carrito!.detalle![indice].precio_unitario! * carrito!.detalle![indice].cantidad!;
            sw = 1;
        }

      }

      if(sw == 0){
        widget._detalle!.cantidad = widget._cantidad;
          
        widget._detalle!.monto_total = widget._cantidad * widget._detalle!.precio_unitario!;

        carrito?.detalle!.add(widget._detalle!);     
      }

    }

}