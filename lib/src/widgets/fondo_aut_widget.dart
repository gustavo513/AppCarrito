import 'package:flutter/material.dart';

class FondoAutWidget extends StatelessWidget{

  //BuildContext? context;
  double? altura;
  bool? activarLogo;
  String? rutaImagen;
  String? encabezado;
  List<Widget>? campos;
  double? separacionCampos;
  String? textoBoton;
  Function? accionBoton;
  Widget? piePagina;

  FondoAutWidget({
    //required BuildContext context,
    required double? altura, 
    String? rutaImagen, 
    bool? activarLogo,
    required String encabezado, 
    required List<Widget> campos, 
    double? separacionCampos,
    required String textoBoton,
    required Function accionBoton,
    Widget? piePagina}){
      //this.context = context;
      this.altura = altura;
      this.rutaImagen = rutaImagen;
      this.activarLogo = activarLogo;
      this.encabezado = encabezado;
      this.campos = campos;
      this.separacionCampos = separacionCampos;
      this.textoBoton = textoBoton;
      this.accionBoton = accionBoton;
      this.piePagina = piePagina;
  }
  
  @override
  Widget build(BuildContext context){
    return _crearFondo(context);
  }
   
  
  Widget _crearFondo(BuildContext context){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * altura!,
          width: MediaQuery.of(context).size.width * 0.90,
          margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 2, // Cuánto se expande la sombra
                  blurRadius: 5, // Qué tan difusa es la sombra
                  offset: Offset(3, 3),                 
                ),
            ],
          ),
          child: Column(
            children: [
              activarLogo == true? _crearLogo(context) : Text(''),
              _crearEncabezado(encabezado!, context),
              _crearCampos(context), 
              _crearBoton(context),
              _crearPiePagina()
            ],
          ),
        ),
      ),
    );
  }

 Widget _crearLogo(BuildContext context){
    return Image(
        height: MediaQuery.of(context).size.height * 0.20,
        image: AssetImage('$rutaImagen')
    );
  }

  Widget _crearEncabezado(String encabezado, BuildContext context){
    return Column(
      children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(encabezado, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05)
      ],
    );
  }

  Widget _crearCampos(BuildContext context){
    return SizedBox(
      width: 300.0,
      child: Column(
        children: _generarCampo(context),
      ),
    );
  }

  List<Widget> _generarCampo(BuildContext context){
    List<Widget> lista = [];

    for(var item in campos!){
      lista.add(item);
      lista.add(SizedBox(height: MediaQuery.of(context).size.height * 0.025));//separacionCampos));
    }

    return lista;
  }

  Widget _crearBoton(BuildContext context){
    return ElevatedButton(
      onPressed: () async {
        await accionBoton!(context);
      
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 4, 38, 175)),
      ),
      child: Text('$textoBoton', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _crearPiePagina(){
    if(piePagina == null){
      return Text('');
    }
    return piePagina!;
  }
}