/*
Kelly Johana Ascanio Rodríguez
CBA mosquera
2470980
fecha: 10/10/""
 */
//se crean los atributos de los poductos
class ProductosModel {
  final String name;
  final String image;
  final String color;
  final int price;
  int quantity;

  ProductosModel({required this.name, required this.image, required this.color, required this.price, this.quantity=1});

}