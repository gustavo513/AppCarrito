class DetalleModel{

  int? id_detalle;
  int? id_producto;
  int? cantidad;
  int? precio_unitario;
  int? monto_total;

  DetalleModel({int? id_detalle, required int id_producto, int cantidad = 1, required int precio_unitario, int? monto_total}){
    this.id_detalle = id_detalle;
    this.id_producto = id_producto;
    this.cantidad = cantidad;
    this.precio_unitario = precio_unitario;
    this.monto_total = monto_total;
  }

  Map<String, dynamic> toJson(){
    return {
      'id_detalle'      :   this.id_detalle,
      'id_producto'     :   this.id_producto,
      'cantidad'        :   this.cantidad,
      'precio_unitario' :   this.precio_unitario,
      'monto_total'     :   this.monto_total,
    };
  }
  
}