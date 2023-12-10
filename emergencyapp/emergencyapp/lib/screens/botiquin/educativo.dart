import 'package:emergencyapp/screens/botiquin/modulos/menu.dart';
import 'package:emergencyapp/screens/botiquin/quizz.dart';
import 'package:flutter/material.dart';

class educativo extends StatefulWidget {
  const educativo({Key? key}) : super(key: key);

  @override
  State<educativo> createState() => _educativoState();
}

class _educativoState extends State<educativo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Educativo',
          style: TextStyle(fontFamily: 'Rowdies'),
        ),
        backgroundColor: Color(0xFFB8D2E4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: 20), // Agregado para separar los widgets
            ElevatedButton(
              onPressed: () {
                // Acción al hacer clic en el botón "¿Qué hay en el botiquín?"
                // Puedes cambiar la acción según tus necesidades
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Menu()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF34797B), // Color de fondo del botón
                padding: EdgeInsets.all(20.0), // Espaciado interno del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      20.0), // Bordes redondeados del botón
                ),
                elevation: 5.0, // Sombra del botón
              ),
              child: Container(
                width: double.infinity, // Ancho del botón al máximo disponible
                child: Text(
                  'Aprendamos juntos\npara saber qué hacer en una emergencia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Rowdies',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
