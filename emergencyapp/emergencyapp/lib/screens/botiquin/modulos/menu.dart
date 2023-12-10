import 'package:flutter/material.dart';
import 'modulo1.dart';
import 'modulo2.dart';
import 'modulo3.dart';
import 'modulo4.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba de Módulos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Principal', style: TextStyle(fontFamily: 'Rowdies' ),),
        backgroundColor: Color(0xFFB8D2E4), // Color del appbar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ModuloButton(nombreModulo: 'Módulo 1', modulo: 1),
            SizedBox(height: 10),
            ModuloButton(nombreModulo: 'Módulo 2', modulo: 2),
            SizedBox(height: 10),
            ModuloButton(nombreModulo: 'Módulo 3', modulo: 3),
            SizedBox(height: 10),
            ModuloButton(nombreModulo: 'Módulo 4', modulo: 4),
          ],
        ),
      ),
    );
  }
}

class ModuloButton extends StatelessWidget {
  final String nombreModulo;
  final int modulo;

  ModuloButton({required this.nombreModulo, required this.modulo});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            if (modulo == 1) {
              return Modulo1();
            } else if (modulo == 2) {
              return Modulo2();
            } else if (modulo == 3) {
              return Modulo3();
            } else if (modulo == 4) {
              return Modulo4();
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Módulo $modulo'),
                ),
                body: Center(
                  child: Text('Contenido del Módulo $modulo'),
                ),
              );
            }
          }),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF34797B), // Color del botón
        onPrimary: Colors.white, // Color del texto del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Padding del botón
      ),
      child: Text(
        nombreModulo,
        style: TextStyle(
          fontFamily: 'Rowdies', // Fuente del texto del botón
          fontSize: 18.0, // Tamaño de fuente del texto del botón
        ),
      ),
    );
  }
}
