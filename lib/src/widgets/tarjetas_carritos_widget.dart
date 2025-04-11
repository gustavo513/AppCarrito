import 'package:client/src/models/detalle_model.dart';
import 'package:client/src/widgets/tab_detalles_carrito.dart';
import 'package:flutter/material.dart';
import 'package:client/src/providers/detalles_provider.dart';

class TarjetasCarritos extends StatelessWidget {

  List<Map<String, dynamic>> lista;

  TarjetasCarritos(this.lista);

  DetallesProvider detallesProvider = new DetallesProvider();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int indice){
    
        final mensaje = lista[indice]["estado_carrito"] == "N"? "Pendiente" : "Aprobado";
        final Color color = lista[indice]["estado_carrito"] == "N"? Colors.amber : Colors.green;
        final Color colorText = lista[indice]["estado_carrito"] == "N"? Colors.black : Colors.white;
    
        return Container(
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.only(left: 10.0),
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 5,
                blurRadius: 7.0,
                offset: Offset(0, 4)
              ),
            ]
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.blue),
                        Text('Carrito Nro.: ${lista[indice]["id_carrito"]}', style: TextStyle(fontSize: 20.0))
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, color: Colors.blue),
                        Text('${lista[indice]["fecha_carrito"]}', style: TextStyle(fontSize: 18.0)),
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 75.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                    ),
                    child: Center(
                      child: Text('$mensaje', style: TextStyle(color: colorText)),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        side: BorderSide(
                          color: Colors.white
                        )
                      ),
                      onPressed: () async {
                         return await showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return FutureBuilder(
                              future: detallesProvider.obtenerDetalles(lista[indice]["id_carrito"]),
                              builder: (context, snapshot) {
                                if(snapshot.hasData){
                                    return AlertDialog(
                                      title: Text('Detalles'),
                                      content: SingleChildScrollView(child: TablaDetallesCarritoWidget(lista: snapshot.data))
                                    );
                                }
                                else{
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            );
                          }
                         );
                      },
                      child: Text('Ver detalles')
                    ),
                  ),
                ],
              ),
            ]
          ),
        );
      },
    );
  }
}