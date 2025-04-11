import 'package:client/src/models/carrito_model.dart';
import 'package:client/src/models/detalle_model.dart';
import 'package:client/src/models/usuario_model.dart';
import 'package:client/src/providers/notificacion_provider.dart';
import 'package:client/src/providers/usuario_provider.dart';
import 'package:client/src/widgets/carrito_contador_widget.dart';
import 'package:client/src/widgets/icon_notificacion.dart';
import 'package:flutter/material.dart';

import 'package:client/src/widgets/menu_lateral_widget.dart';
import 'package:client/src/routes/imagenes.dart';
import 'package:client/src/widgets/carrito_widget.dart';

int? idUsuario;

Carrito? carrito;

class HomePage extends StatefulWidget{

  String? _token;

  State<HomePage> createState() => HomePageState();

}

class HomePageState extends State<HomePage>{

   NotificacionProvider?  notifProv;

  initState() {
    super.initState();

    notifProv = new NotificacionProvider();

    UsuarioProvider usuario = new UsuarioProvider();

    _obtenerToken(notifProv!).then((token){
      if(widget._token != null){
        usuario.actualizarTokenFirebase(token: widget._token!, id: idUsuario!);
      }
    });

    notifProv!.notificacionPrimerPlano(context);

  }

  Future<void> _obtenerToken(NotificacionProvider notif) async{
    String? token;

    token = await notif!.initNotificacion();

    if(token != null){
      setState((){
        widget._token = token;
      });
    }
  }

  @override
  Widget build(BuildContext context){

    if(carrito == null){
      carrito = Carrito(id_usuario: idUsuario, detalle: []);
    }

    return Scaffold(
      appBar: AppBar(
            title: Center(
              child: Text('Productos', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            leading: Image(
                  image: AssetImage('assets/hilagro_logo_blanco.png')
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromARGB(255, 46, 73, 159),
      ),
      endDrawer: MenuLateralWidget(),
      floatingActionButton: CarritoContadorWidget(),
      body: _generarGrid(),
      backgroundColor: Colors.grey,
    );
  }

  Widget _generarGrid(){

    List<Map<String, dynamic>> imagenes = getImagenesProducto();

    return GridView.builder(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
      ),
      itemCount: imagenes.length,
      itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.all(10.0),
          width: 80.0,
          height: 70.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.0015,),
              _obtenerImagenProducto(imagenes, index, context),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0015,),
              Text('${imagenes[index]['titulo']}', style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018), overflow: TextOverflow.ellipsis,),
              Text('Gs ${imagenes[index]['precio']}', style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.018, fontWeight: FontWeight.bold)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.0015,),
              CarritoWidget(detalle: new DetalleModel(id_producto: imagenes[index]['id'], precio_unitario: imagenes[index]['precio'])),
            ],
          ),
        );
        
      },
    );
  }

  Text _generarDescripcionProducto(List<Map<String, dynamic>> imagenes, int index) => Text('${imagenes[index]["titulo"]}', style: TextStyle(fontSize: 12.0), overflow: TextOverflow.ellipsis,);

  FadeInImage _obtenerImagenProducto(List<Map<String, dynamic>> imagenes, int index, BuildContext context) {
    return FadeInImage(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              image: NetworkImage('${imagenes[index]["url"]}'),
              placeholder: AssetImage('assets/loading.gif'),
            );
  }
 
}