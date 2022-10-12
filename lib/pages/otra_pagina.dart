/*
Kelly Johana Ascanio Rodríguez
CBA mosquera
2470980
fecha: 10/10/""
 */
//esta pagina solo es de prueba no se ha finalizado
import 'package:flutter/material.dart';

class OtraPagina extends StatefulWidget {
  const OtraPagina({Key? key}) : super(key: key);

  @override
  State<OtraPagina> createState() => _OtraPaginaState();
}

class _OtraPaginaState extends State<OtraPagina> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Otra Página',
           style: TextStyle(fontSize: 15.0),
        ),
      ),
    );
  }
}
