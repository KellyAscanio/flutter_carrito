/*
Kelly Johana Ascanio Rodríguez
CBA mosquera
2470980
fecha: 10/10/""
 */
import 'package:carrito_compras/models/produtos_models.dart';
import 'package:flutter/material.dart';

import 'pages/pedido_lista.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //quitamos el debug que viene por defecto
      title: 'Carrito', //titulo del sitio
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Aplicacion Compras'), //asigno un titulo al appbar
    );
  }
}

class MyHomePage extends StatefulWidget { //se usa cuando se crea algo que pueda cambiar su estado
  const MyHomePage({super.key, required this.title});

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  //instanciamos nuestro producto model y lo ponemos en un array
  List<ProductosModel> _productosModel = <ProductosModel>[];
  //se crea otra lista para que el carro vaya agregando los productos
  final List<ProductosModel> _listaCarro = <ProductosModel>[];

  @override
  //hace llamado por así decirlo a la base de datos _productosDb donde guarda los productos
  void initState() { // se llama cuando se crea un objeto para su widget con estado y se inserta dentro del árbol de widgets. Es básicamente el punto de entrada para el Stateful Widget
    super.initState();
    _productosDb();
  }
  @override
  Widget build(BuildContext context) { //cuando lo construyo nos dice en que entorno o estado está el obj "atrás, en el medio, delante o arriba"
    return  Scaffold(//La arquitectura,distribución de la interfaz, se define en donde va a ser ubicado cada widget.
      appBar: AppBar( //head de la pagina
        title: Text(widget.title), //texto
        actions: <Widget>[ //Una lista de widgets para mostrar en una fila después del widget de título
          Padding(padding: //agrega relleno o espacio vacío alrededor de un widget o un montón de widgets.
          const EdgeInsets.only(right: 16.0, top: 8.0),
          child: GestureDetector( //es un widget no visual que se utiliza principalmente para detectar el gesto del usuario.
            child: Stack( //es un widget incorporado en flutter SDK que nos permite crear una capa de widgets colocándolos uno encima del otro
              alignment: Alignment.topCenter,
              children:<Widget> [ //children contiene varios widgets.
                const Icon(Icons.shopping_cart, size: 38,),
                if (_listaCarro.isNotEmpty) //condicional para estar coprobando el estado de los productos
                  Padding(padding: const EdgeInsets.only(left: 2.0),
                  child: CircleAvatar( //diseño de la cantidad de productos seleccionados
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      _listaCarro.length.toString(), //el numero de la cantidad de productos va incrementando
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                    ),
                  ),
                  )
              ],
            ),
            onTap: (){ //al momento de dar click  envia directamente a la lista de pedidos, es decir a la lista carrito
              if(_listaCarro.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(//ir a otra pagina
                    builder: (context) => Cart(_listaCarro), //se instancia el listado
                ),
                );
              }
            },
          ),
          )
        ],
      ), //Barra de título
        body: _cuadroProductos(), //cuerpo de la pagina en este caso el metodo cuadroProductos()
      drawer: SizedBox( //permite crear menú en la parte izquier
       width: 170.0,
        child: Drawer(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.black,
            child: ListView( //lista
              padding: const EdgeInsets.only(top: 50.0), //only define en que parte estará ubicado
              children: const <Widget> [//children contiene varios widgets.
                SizedBox( //sideBox es un cuadro con un tamaño definido
                  height: 120,
                  child: UserAccountsDrawerHeader( //Contiene una foto o una descripcion
                      accountName: Text(''),
                      accountEmail:  Text(''),
                      decoration:  BoxDecoration(
                        image:  DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('LogoSample_ByTailorBrands (2).jpg'),

                        )
                      ),
                )
                ),
                Divider(), //hace una division entre los widgets
                ListTile( //widget que contiene un icono con sus caracteristicas
                  title: Text('Home', style: TextStyle(color: Colors.white),),
                  trailing: Icon
                    (Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),


    )
    );
  }
  //dridview de productos donde nos va a mostrar cada producto en un cuadro
  GridView _cuadroProductos(){
    return GridView.builder(
        padding: const EdgeInsets.all(4.0), //determinamos que tenga un padding de 4.0
       gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), //determinamos cuantas columnas queremos
      itemCount: _productosModel.length, //registra la cantidad de productos
      itemBuilder: (context, index){
          final String imagen = _productosModel[index].image;  //guardamos en la variable imagen
          var item = _productosModel[index]; //lista de producto
          //retorna all incluyed in the index
          return Card(
            elevation: 4.0,
            child: Stack( //stack permite obre poner sobre otro widget
              fit: StackFit.loose, //permite sobre poner sobre otro widget
              alignment: Alignment.center, //alineacion
              children: <Widget>[ //permite agregar varios widget
                Column( //agregamos una columna
                  mainAxisAlignment: MainAxisAlignment.center, //la alineamos centrada
                  children: <Widget>[
                    Expanded(child:  Image.asset("images/$imagen", //se hace llamado de imagen
                      fit: BoxFit.contain),),
                 Text(item.name, //muestra el nombre del producto
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 2.0,
                      color: Colors.black
                      ),),
                  const SizedBox(
                    height: 10,
                  ),
                    Row( //creamos una fila donde agregamos el precio y el icono del carrito para selecionar
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[//agregamos varios widgets
                        const SizedBox(
                          height: 25,
                        ),
                        Text(item.price.toString(), style: const TextStyle( //muestra el precio del producto
                          fontWeight: FontWeight.bold,
                          fontSize:  23.0,
                          color: Colors.black
                        ),),
                        Padding(padding: const EdgeInsets.only(
                          right: 8.0,
                          bottom: 8.0,
                        ),
                        child: Align(alignment: Alignment.bottomRight,
                        child: GestureDetector( //Gesturn detector es un widget no visual que se utiliza principalmente para detectar el gesto del usuario.
                          child: (!_listaCarro.contains(item)) //creamos el carrito para seleccionar
                          //el simbolo de admiracion hace referencia a si la lista esta vacia
                              ?const Icon(Icons.shopping_cart,  //usamos condicional if-else
                              color: Colors.green, //0
                              size: 38,
                              ):
                              const Icon(Icons.shopping_cart,
                              color: Colors.red, //1
                              size: 38,
                              ),
                          onTap: (){// es practicamente la misma condicional que hicimos anteriormente
                            setState(() { //setState hace parte de los listados, siempre los necesitamos cuando
                              //vamos a hacer cambios, el actualiza
                              if(!_listaCarro.contains(item)) {
                                _listaCarro.add(item);
                              } else {
                                _listaCarro.remove(item);
                              }

                            });
                          },


                        ),),),

                      ],
                    )
                  ],
                )
              ],
            ));

      },
    );
  }
  //metodo para regular una base de datos ya que no estamos consumiendo realmente
  void _productosDb(){
    var list = <ProductosModel>[ //listado de los productos
      ProductosModel(name: 'Leche', image:'leche1.jpg', color: 'Blanco', price: 14000),
      ProductosModel(name: 'Huevos', image:'huevos2.jpg', color: 'Amarillo', price: 12000),


    ];
    setState(() { //hace parte del manejo de los listados
      _productosModel = list;
    }); //cuando se hagan cambios el lo actualiza
  }
}

