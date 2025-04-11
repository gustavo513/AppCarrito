import 'package:flutter/material.dart';

import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/providers/carrito_provider.dart';
import 'package:client/src/widgets/tarjetas_carritos_widget.dart';

/*
  Este widget muestra una lista de carritos pendientes o aprobados, dependiendo del estado de los carritos existentes en la lista
*/

class HistorialCarritosPage extends StatefulWidget{

  String? estadoCarrito;

  HistorialCarritosPage({this.estadoCarrito});

  State<HistorialCarritosPage> createState() => HistorialCarritosState();

}

class HistorialCarritosState extends State<HistorialCarritosPage>{

  CarritoProvider carritoProvider = new CarritoProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: carritoProvider.listarCarritosPorEstado(widget.estadoCarrito!),
      builder: (context, snapshot) {
          if(snapshot.hasData){
              return TarjetasCarritos(snapshot.data!);
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        );
    }

}

