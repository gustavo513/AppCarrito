import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/pages/historial_carritos_page.dart';
import 'package:client/src/providers/carrito_provider.dart';
import 'package:client/src/providers/clientes_provider.dart';
import 'package:client/src/providers/detalles_provider.dart';
import 'package:client/src/widgets/tab_detalles_carrito.dart';
import 'package:client/src/widgets/tarjetas_carritos_widget.dart';
import 'package:flutter/material.dart';
import 'package:client/src/pages/carrito_detalle_page.dart';
import 'package:client/src/widgets/botonesNavBar_widget.dart';
import 'package:client/src/widgets/menu_lateral_widget.dart';

import 'package:client/src/widgets/tabla_detalles_widget.dart';



class CarritoPage extends StatefulWidget{

  State<CarritoPage> createState() => CarritoPageState();

}

class CarritoPageState extends State<CarritoPage>{

  int? _indiceSelecionado = 0;

  CarritoProvider? carritoProvider;
  List<Carrito>? listaCarritos;

  @override
  List<Widget>? paginas = [
      CarritoDetallePage(),
      HistorialCarritosPage(estadoCarrito: "N"), //carga en la página los carritos con estado pendiente de aprobación
      HistorialCarritosPage(estadoCarrito: "S"), //carga en la página los carritos aprobados
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text('Carrito', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            leading: Image(
                  image: AssetImage('assets/hilagro_logo_blanco.png')
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 46, 73, 159),
      ),
      endDrawer: MenuLateralWidget(),
      body: paginas![_indiceSelecionado!],
      bottomNavigationBar: BotonesNavBarWidget(_cambiarPagina),
    );
  }

  void _cambiarPagina(int indice){
    setState((){
      _indiceSelecionado = indice;
    });
  }
 
}