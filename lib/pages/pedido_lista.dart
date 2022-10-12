/*
Kelly Johana Ascanio Rodríguez
CBA mosquera
2470980
fecha: 10/10/""
 */
import 'package:carrito_compras/models/produtos_models.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final List<ProductosModel> _cart;
  const Cart(this._cart, {super.key});

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController(); //controller
  var _firstScroll = true;
  bool _enabled = false; //boton

  List<ProductosModel> _cart;

  Container pagoTotal(List<ProductosModel> _cart) {
    return Container(//widget que nos retorna un container del pago total
      //diseño
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text("Total: \$${valorTotal(_cart)}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }
  //metodo para obtener el valor total de la copra
  String valorTotal(List<ProductosModel> listaProductos) {
    double total = 0.0; //double para manejar decimales
    for (int i = 0; i < listaProductos.length; i++) { //va a recorrer todos los productos seleccionados
      total = total + listaProductos[i].price * listaProductos[i].quantity; //operacion
    }
    //retorna el total
    return total.toStringAsFixed(
        2); //se tranforma la operacion en un string para mostrarla
  }
  String valorUnitario(List<ProductosModel> listaProductos) {
    double total = 0.0; //double para manejar decimales
    for (int i = 0; i < listaProductos.length; i++) { //va a recorrer todos los productos seleccionados
      total = (listaProductos[i].price * listaProductos[i].quantity) as double; //operacion
    }
    return total.toStringAsFixed(
        2); //se tranforma la operacion en un string para mostrarla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//La arquitectura,distribución de la interfaz, se define en donde va a ser ubicado cada widget.
      appBar: AppBar( //barra de titulo
        actions: const <Widget>[
          IconButton( //creamos un icono en la  barra
            icon: Icon(Icons.no_food_rounded),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: const Text( //se le agrega un texto
          'Detalle',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(//se agrega icono y se le crea una funcionalidad de devolver
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); //se utiliza para regresar
            setState(() {
              //para que actualice la cantidad de items que tiene
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector( //detector de gestos
          //Controlar el Scroll
          onVerticalDragUpdate: (details) { //navegacion vertical
            if (_enabled && _firstScroll) {
              _scrollController.jumpTo(_scrollController.position.pixels -
                  details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection:
                    Axis.vertical,  //estamos definiendo el scroll en vertical
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String imagen = _cart[index].image; //instancia la imagen
                  var item = _cart[index]; //
                  return Column(//widget columna
                    children: <Widget>[ // contiene varios widgets
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: <Widget>[
                            Row(//fila que contiene la imagen
                              children: <Widget>[
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset("images/$imagen",
                                      fit: BoxFit.contain),
                                )),
                                Column( //contiene el nombre
                                  children: <Widget>[
                                    Text(item.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    Row( //este row esta dentro de otro row
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container( //widget que contiene el boton de incremento
                                          width: 120,
                                          height: 40,
                                          decoration: const BoxDecoration( //diseño
                                              color: Colors.red,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.blue,
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: const EdgeInsets.only(top: 20.0),
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              const SizedBox(
                                                height: 8.00,
                                              ),
                                              IconButton(//icono de restar
                                                icon: const Icon(Icons.remove),
                                                onPressed: () { //cuando presione
                                                  _removeProduct(index);  //lamamos el metodo remove para disminiur la cantidad
                                                  valorTotal(_cart); //envia el valor total
                                                },
                                                color: Colors.white,
                                              ),
                                              Text('${_cart[index].quantity}', style: const TextStyle( //widget que muestra la cantidad
                                                //de productos que desea llevar
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.black)),
                                              IconButton( //icono de agregar cantidad de producto
                                                icon: const Icon(Icons.add),
                                                onPressed: () {//al presionar
                                                  _addProduct(index); //llamamos el metodo para que se incremente
                                                  valorTotal(_cart); //envie el valor total
                                                },
                                                color: Colors.white,
                                              ),

                                              const SizedBox( //espacio
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox( //otro espacio
                                  height: 38.0,
                                ),
                                Text(item.price.toString(), //widget muestra el precio individual del producto
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                        color: Colors.black)),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Divider( //se genera una pequeña division
                        color: Colors.purple,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              const SizedBox(
                width: 20.0,
              ),

            ],
          ))),
    );
  }
//metodo para agregar producto
  _addProduct(int index) {
    //Funcion para adicionar los productos
    setState(() {//actuaiza la cantidad
      _cart[index].quantity++;
    });
  }
//metodo para remover producto
  _removeProduct(int index) {
    //Funcion para restar los productos
    setState(() { //actuaiza la cantidad
      _cart[index].quantity--;
    });
  }
}
