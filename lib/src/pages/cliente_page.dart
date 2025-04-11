import 'package:client/src/widgets/menu_lateral_widget.dart';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';

import 'package:client/src/providers/clientes_provider.dart';

class ClientePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text('Clientes', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            leading: Image(
                  image: AssetImage('assets/hilagro_logo_blanco.png')
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 46, 73, 159),
      ),
      endDrawer: MenuLateralWidget(),
      body: SafeArea(
        minimum: EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              
              children: _obtenerClientes(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearColumnas(){
    return     Row(
                  spacing: 50.0,
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: Text('Clave cliente', textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic))
                    ),
                    SizedBox(
                      width: 150.0,
                      child: Text('Nombre cliente', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: Text('Descripción', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: Text('Sucursal', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                    SizedBox(
                      width: 150.0,
                      child: Text('Crédito', style: TextStyle(fontStyle: FontStyle.italic)),
                    ),
                  ]
                );
}

  List<Widget> _obtenerClientes(){

    List<Widget> clientes = []; //lista de rows

    clientes.add(_crearColumnas()); //añade como row el nombre de las columnas para la tabla

    List<Map<String, dynamic>> datosCliente = _obtenerDatosClientes();  //obtiene los datos de los clientes de una lista de mapas

    Widget? cajaValor;

    Widget? fila;

    double? ancho;

    for(var item in datosCliente){

      List<Widget> cajasEnlazadas = [];
      
      item.forEach((key, value) {

        if(key == 'clave'){
          ancho = 70.0;
        }
        else if(key == 'nombre'){
          ancho = 140.0;
        }
        else{
          ancho = 150.0;
        }
        
        cajaValor = SizedBox(
                      width: ancho,
                      height: 65.0,
                      child: Text('${value.toString()}', textAlign: TextAlign.center,)       
        );

        cajasEnlazadas.add(cajaValor!);

      });


      clientes.add(Row(
        spacing: 50.0,
        children: cajasEnlazadas,
      ));


    }

    return clientes;
  }

  List<Map<String, dynamic>> _obtenerDatosClientes(){
    List<Map<String, dynamic>> listadoCliente = [];

    final clientes = lista["clientes"];

    for(var item in clientes!){
      if(item != null){
        listadoCliente.add(item);
      }
    }

    return listadoCliente;
  }
}