import 'package:flutter/material.dart';

class BotonesNavBarWidget extends StatefulWidget{

  Function? _cambiarPagina;

  BotonesNavBarWidget(Function cambiarPagina){
    this._cambiarPagina = cambiarPagina;
  }

  State<BotonesNavBarWidget> createState() => BotonesNavBarWidgetState();

}

class BotonesNavBarWidgetState extends State<BotonesNavBarWidget>{

  int _indiceSelecionado = 0;

  void _cambiarSeleccion(int indice){
    _indiceSelecionado = indice;
    widget._cambiarPagina!(indice);
  }

  @override
  Widget build(BuildContext context){
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Carrito',
            icon: Icon(Icons.shopping_cart)
          ),
          BottomNavigationBarItem(
            label: 'Pendientes',
            icon: Icon(Icons.pending),
          ),
          BottomNavigationBarItem(
            label: 'Aprobados',
            icon: Icon(Icons.check)
          ),
        ],
        currentIndex: _indiceSelecionado,
        onTap: _cambiarSeleccion,
      );
  }

}