// lib/modulo1.dart

import 'package:flutter/material.dart';

class Modulo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 1', style: TextStyle(fontFamily: 'Rowdies'),
        
        ),
        backgroundColor: Color(0xFFB8D2E4),
      ),

      
      body: Modulo1Contenido(),
    );
  }
}





class Modulo1Contenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contenido del Módulo 1 - Primeros Auxilios',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Tema: Manejo de Heridas y Quemaduras',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              _buildSeccionTitulo('Cortaduras y Raspaduras'),
              _buildSeccionContenido(
                'Las cortaduras y raspaduras son lesiones cutáneas comunes que pueden ocurrir en la vida diaria. Es esencial abordarlas adecuadamente para prevenir infecciones y facilitar una recuperación más rápida. A continuación, se describen las características de cada una:'
              ),
              _buildSeccionTitulo('Características de las Cortaduras:'),
              _buildSeccionContenido(
                'Definición: Una cortadura es una herida causada por un objeto afilado, como cuchillos o vidrio.\n\nSíntomas Comunes: Sangrado, dolor, posible pérdida de tejido.\n\nManejo Inicial:\n- Control del Sangrado:\n  - Aplica presión directa sobre la herida con un apósito limpio o pañuelo.\n  - Eleva la extremidad afectada para reducir el flujo sanguíneo.\n\n- Limpieza:\n  - Utiliza agua y jabón suave para limpiar la herida.\n  - Evita el uso de productos irritantes como alcohol.'
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagenConMarcoNegro('assets/sangrado.jpg'),
                  _buildImagenConMarcoNegro('assets/desinfectar.jpeg'),
                ],
              ),
              SizedBox(height: 20.0),
              _buildSeccionTitulo('Características de las Raspaduras:'),
              _buildSeccionContenido(
                'Definición: Una raspadura es una lesión superficial de la piel causada por fricción contra una superficie áspera.\n\nSíntomas Comunes: Enrojecimiento, dolor, pérdida de piel superficial.\n\nManejo Inicial:\n- Limpieza:\n  - Lava la zona afectada con agua y jabón para prevenir infecciones.\n  - Aplica un ungüento antibiótico y cubre con una venda limpia.'
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagenConMarcoNegro('assets/raspadura.jpg'),
                  _buildImagenConMarcoNegro('assets/medicamento.jpg'),
                  _buildImagenConMarcoNegro('assets/bendaje.jpg'),
                ],
              ),
              SizedBox(height: 20.0),
              _buildSeccionTitulo('Quemaduras con Ampollas'),
              _buildSeccionContenido(
                'Las quemaduras con ampollas son lesiones más graves que requieren cuidado especial. Es crucial manejarlas correctamente para minimizar el riesgo de infecciones y promover una curación adecuada. A continuación, se describen las características:'
              ),
              _buildSeccionTitulo('Características de las Quemaduras con Ampollas:'),
              _buildSeccionContenido(
                'Definición: Lesión causada por la exposición a sustancias calientes, como líquidos o fuego.\n\nSíntomas Comunes: Ampollas llenas de líquido, enrojecimiento, dolor intenso.\n\nManejo Inicial:\n- Enfriamiento:\n  - Enfría la quemadura con agua corriente durante al menos 10 minutos.\n  - Evita el uso de hielo, ya que puede dañar los tejidos.\n\n- Cubrimiento:\n  - Cubre la quemadura con un apósito limpio o paño húmedo.\n  - No revientes las ampollas; esto aumenta el riesgo de infección.'
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagenConMarcoNegro('assets/quemadura.jpg'),
                  _buildImagenConMarcoNegro('assets/no_hielo.jpg'),
                  _buildImagenConMarcoNegro('assets/ampolla.jpg'),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Modulo1Preguntas()),
                  );
                },
                child: Text('Ir a las preguntas',
                 style: TextStyle(fontFamily: 'Rowdies'),),
                 style: ElevatedButton.styleFrom(
                primary: Color(0xFF34797B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
              ),
                 ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagenConMarcoNegro(String rutaImagen) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          rutaImagen,
          width: 270.0,
          height: 270.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSeccionTitulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
    );
  }

  Widget _buildSeccionContenido(String contenido) {
    return Text(
      contenido,
      style: TextStyle(fontSize: 16.0, fontFamily: 'Rowdies'),
    );
  }
}





class Modulo1Preguntas extends StatefulWidget {
  @override
  _Modulo1PreguntasState createState() => _Modulo1PreguntasState();
}

class _Modulo1PreguntasState extends State<Modulo1Preguntas> {
  List<Pregunta> preguntas = obtenerPreguntas();
  int indicePreguntaActual = 0;

  @override
  Widget build(BuildContext context) {
    return preguntas.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    preguntas[indicePreguntaActual].pregunta,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      fontFamily: 'Rowdies'
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: preguntas[indicePreguntaActual].opciones.map((opcion) {
                      return RadioListTile(
                        title: Text(opcion),
                        value: opcion,
                        groupValue: preguntas[indicePreguntaActual].respuestaSeleccionada,
                        onChanged: (String? value) {
                          setState(() {
                            preguntas[indicePreguntaActual].respuestaSeleccionada = value;

                            if (preguntas[indicePreguntaActual].respuestaCorrecta == value) {
                              mostrarMensaje('Respuesta correcta', Colors.green);
                            } else {
                              mostrarMensajeConExplicacion(
                                'Respuesta incorrecta',
                                Colors.red,
                                preguntas[indicePreguntaActual].respuestaCorrecta,
                                preguntas[indicePreguntaActual].explicacion,
                              );
                            }

                            // Avanzar automáticamente a la siguiente pregunta
                            avanzarASiguientePregunta();
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Text('Fin del módulo'),
          );
  }

  void avanzarASiguientePregunta() {
    setState(() {
      if (indicePreguntaActual < preguntas.length - 1) {
        // Si hay más preguntas, avanzar al índice siguiente
        indicePreguntaActual++;
      } else {
        // Si ya no hay más preguntas, mostrar un mensaje de finalización o regresar a la pantalla principal
        mostrarMensaje('Fin del módulo', Colors.blue);
        // Puedes agregar aquí lógica adicional al finalizar el módulo
      }
    });
  }

  void mostrarMensaje(String mensaje, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: color,
      ),
    );
  }

  void mostrarMensajeConExplicacion(
    String mensaje,
    Color color,
    String respuestaCorrecta,
    String explicacion,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mensaje, style: TextStyle(color: color, fontFamily: 'Rowdies')),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('La respuesta correcta es: $respuestaCorrecta'),
              SizedBox(height: 8),
              Text('Explicación: $explicacion'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Pregunta {
  final String pregunta;
  final List<String> opciones;
  String? respuestaSeleccionada; // Almacena la respuesta seleccionada por el usuario
  final String respuestaCorrecta;
  final String explicacion;

  Pregunta({
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
  });
}

List<Pregunta> obtenerPreguntas() {
  return [
    Pregunta(
      pregunta: 'En caso de cortaduras o raspaduras, ¿cuál es la mejor opción para limpiar la herida?',
      opciones: [
        'Alcohol',
        'Agua oxigenada',
        'Agua y jabón suave',
        'Vinagre'
      ],
      respuestaCorrecta: 'Agua y jabón suave',
      explicacion:
          'Para limpiar cortaduras o raspaduras, la mejor opción es utilizar agua y jabón suave. El alcohol y la agua oxigenada pueden irritar la herida.',
    ),
    Pregunta(
      pregunta: '¿Qué se debe hacer si alguien sufre una picadura de abeja y la picadura queda incrustada?',
      opciones: [
        'Raspar la picadura con las uñas',
        'Aplicar hielo inmediatamente',
        'Retirar la picadura con pinzas',
        'Presionar la picadura hasta que salga'
      ],
      respuestaCorrecta: 'Retirar la picadura con pinzas',
      explicacion:
          'En caso de picadura de abeja, se debe retirar la picadura con pinzas para evitar que se liberen más veneno. Raspar o presionar la picadura puede empeorar la situación.',
    ),
    Pregunta(
      pregunta: 'Si alguien presenta una quemadura con ampollas, ¿qué se debe hacer?',
      opciones: [
        'Reventar las ampollas con una aguja esterilizada',
        'Aplicar crema de cortisona',
        'Cubrir las ampollas con un apósito limpio',
        'Sumergir la quemadura en agua caliente'
      ],
      respuestaCorrecta: 'Cubrir las ampollas con un apósito limpio',
      explicacion:
          'En caso de quemaduras con ampollas, se deben cubrir las ampollas con un apósito limpio para proteger la piel. Reventar las ampollas puede aumentar el riesgo de infección.',
    ),
  ];
}