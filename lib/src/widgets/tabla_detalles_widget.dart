import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/models/detalle_model.dart';
import 'package:client/src/pages/carrito_page.dart';
import 'package:client/src/pages/home_page.dart';
import 'package:client/src/routes/imagenes.dart';
import 'package:client/src/widgets/cuadro_eliminacion_widget.dart';
import 'package:flutter/material.dart';

class TablaDetallesWidget extends StatefulWidget{

  State<TablaDetallesWidget> createState() => TablaDetallesWidgetState();

}

class TablaDetallesWidgetState extends State<TablaDetallesWidget>{

  CarritoPage carritoPage = new CarritoPage();

  final List<DataColumn> _listaColumnas = [
    DataColumn(label: Text('Producto')), 
    DataColumn(label: Text('Cantidad')), 
    DataColumn(label: Text('Precio Unitario')), 
    DataColumn(label: Text('Subtotal')),
    DataColumn(label: Text('')),
    DataColumn(label: Text('')),
  ];

  List<Map<String, dynamic>> productos = getImagenesProducto();

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _listaColumnas,
        rows: _getDatosProductos(productos),
      ),
    );
  }

  List<DataRow> _getDatosProductos(List<Map<String, dynamic>> productos){

      final List<DataRow> datos = [];

      DataRow? fila;

      if(carrito?.detalle != null){

        for(var itemDetalle in carrito!.detalle!){
          
          for(var item in productos){

            if(itemDetalle.id_producto == item['id']){
              datos.add( DataRow(cells: _getCeldas(itemDetalle, item['titulo'])) );
            }

          }

        }
        return datos;
      }
      return [];
  }

  List<DataCell> _getCeldas(DetalleModel detalle, String producto){
    List<DataCell> celdas = [];

    celdas.add(DataCell(Text(producto)));
    celdas.add(DataCell(Text('${detalle.cantidad}')));
    celdas.add(DataCell(Text('${detalle.precio_unitario}')));
    celdas.add(DataCell(Text('${detalle.monto_total}')));
    celdas.add(DataCell(
      IconButton(
        onPressed: (){
          _crearCuadroForm(detalle.id_producto!, detalle.cantidad!);
        },
        icon: Icon(Icons.edit, color: Colors.blue),
      ),
    ));
    celdas.add(DataCell(
      IconButton(
        onPressed: (){
          _quitarProducto(detalle.id_producto!);
        },
        icon: Icon(Icons.delete, color: Colors.red)
      )
    ));

    return celdas;
  }

  Future<void> _crearCuadroForm(int idProducto, int cantidad){

    TextEditingController cantidadController = TextEditingController();

    cantidadController.text = '$cantidad';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Editar cantidad'),
          content: SizedBox(
            width: 50.0,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
              controller: cantidadController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: (){
                final valor = int.parse(cantidadController.text);
                _editarCantidadProducto(idProducto, valor);
                Navigator.of(context).pop();
                Navigator.of(context).popAndPushNamed('/carrito');
              },
              child: Text('Guardar')
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            )
          ]
        );
      }
    );
  }

  void _editarCantidadProducto(int idProducto, int cantidad){
    
    int sw = 0;

    for(int i = 0; i < carrito!.detalle!.length && sw == 0; i++){

      if(carrito!.detalle![i].id_producto == idProducto){
        carrito!.detalle![i].cantidad = cantidad;
        carrito!.detalle![i].monto_total = carrito!.detalle![i].precio_unitario! * carrito!.detalle![i].cantidad!;
        sw = 1;
      }
    }

  }

  void _quitarProducto(int id_producto) async{

    DetalleModel? aux;

    for(var item in carrito!.detalle!){
      
      if(item.id_producto == id_producto){
        aux = item;
      }
    }

    final respuesta = await confirmarEliminacion(context: context, titulo: 'Confirmar eliminación', mensaje: '¿Está seguro de que desea quitar el producto seleccionado del carrito?');

    if(respuesta == 1){
      carrito!.detalle!.remove(aux);
      Navigator.of(context).popAndPushNamed('/carrito');
    }
  }

}