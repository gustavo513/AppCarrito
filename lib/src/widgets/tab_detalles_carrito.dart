import 'package:flutter/material.dart';

import 'package:client/src/models/detalle_model.dart';
import 'package:client/src/routes/imagenes.dart';

class TablaDetallesCarritoWidget extends StatelessWidget{

  List<DetalleModel>? lista;

  int sumatoria = 0;

  TablaDetallesCarritoWidget({this.lista});

  List<String> columnas = [
    "Clave Producto",
    "Descripción",
    "Cantidad",
    "Precio Unitario",
    "Subtotal"
  ];

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DataTable(
            columns: _generarColumnas(),
            rows: _generarFilas(),
          ),
          Text('Total: $sumatoria', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0))
        ],
      ),
    );
  }


  List<DataColumn> _generarColumnas(){
    
    List<DataColumn> listaColumnas = [];

    for(int i = 0; i < columnas.length; i++){
      DataColumn columna = DataColumn(
        label: Text(columnas[i]),
      );

      listaColumnas.add(columna);
    }

    return listaColumnas;
  }

  List<DataRow> _generarFilas(){
    
    List<DataRow> listaFilas = [];

    for(var item in lista!){
      final fila = DataRow(
        cells: _generarCeldas(item),
      );

      listaFilas.add(fila);
    }

    return listaFilas;
  }


  List<DataCell> _generarCeldas(DetalleModel detalle){
    List<DataCell> listaCeldas = [];

    listaCeldas.add(
      DataCell(Center(child: Text('${detalle.id_producto}')))
    );

    listaCeldas.add(
      DataCell(Text(_obtenerNombreProducto(detalle.id_producto!)))
    );

    listaCeldas.add(
      DataCell(Center(child: Text('${detalle.cantidad}')))
    );

    listaCeldas.add(
      DataCell(Text('${detalle.precio_unitario}'))
    );

    listaCeldas.add(
      DataCell(Text('${detalle.monto_total}'))
    );

    sumatoria = sumatoria + detalle.monto_total!;

    return listaCeldas;
  }


  String _obtenerNombreProducto(int idProducto){

    List<Map<String, dynamic>> imagenes = getImagenesProducto();

    for(var item in imagenes){
      
      if(item["id"] == idProducto){
        return item["titulo"];
      }
    }

    return "Sin nombre";
  }

}