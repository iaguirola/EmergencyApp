// lib/modulo3.dart

import 'package:flutter/material.dart';

class Modulo3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 3', style: TextStyle(fontFamily: 'Rowdies'),),
      ),
      body: Modulo3Contenido(),
    );
  }
}

class Modulo3Contenido extends StatelessWidget {
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
            'Contenido del Módulo 3 - Asfixia y Atragantamiento',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            'Tema: Respuestas a situaciones de asfixia y atragantamiento',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImagenConMarcoNegro('assets/asfixia1.jpg'),
              _buildImagenConMarcoNegro('assets/asfixia2.jpg'),
              _buildImagenConMarcoNegro('assets/asfixia3.jpg'),
            ],
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Síntomas Comunes de Asfixia y Atragantamiento'),
          _buildSeccionContenido(
            'Los síntomas comunes de asfixia y atragantamiento incluyen la incapacidad para hablar o dificultad para respirar. '
            'Estos signos indican que las vías respiratorias pueden estar bloqueadas por un objeto extraño.'
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Paso Inicial para Tratar a Alguien Atragantándose'),
          _buildSeccionContenido(
            'El paso inicial para tratar a alguien que está atragantándose es aplicar compresiones abdominales utilizando la maniobra de Heimlich. '
            'Esta técnica ayuda a expulsar el objeto extraño de las vías respiratorias.'
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Acción Recomendada si Pierde el Conocimiento'),
          _buildSeccionContenido(
            'Si una persona pierde el conocimiento debido a la asfixia, la siguiente acción recomendada es iniciar la reanimación cardiopulmonar (RCP). '
            'La RCP ayuda a mantener el flujo sanguíneo y la oxigenación hasta que llegue ayuda profesional.'
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Modulo3Preguntas()),
              );
            },
            child: Text('Ir a las preguntas', style: TextStyle(fontFamily: 'Rowdies',)),
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

class Modulo3Preguntas extends StatefulWidget {
  @override
  _Modulo3PreguntasState createState() => _Modulo3PreguntasState();
}

class _Modulo3PreguntasState extends State<Modulo3Preguntas> {
  List<Pregunta> preguntas = obtenerPreguntasModulo3();
  int indexPregunta = 0; // Nuevo índice para controlar la pregunta actual
  int puntaje = 0;
  int totalPuntos = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(preguntas[indexPregunta].pregunta),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: preguntas[indexPregunta].opciones.map((opcion) {
              return RadioListTile(
                title: Text(opcion),
                value: opcion,
                groupValue: preguntas[indexPregunta].respuestaSeleccionada,
                onChanged: (String? value) {
                  setState(() {
                    preguntas[indexPregunta].respuestaSeleccionada = value;

                    if (preguntas[indexPregunta].respuestaCorrecta == value) {
                      // Respuesta correcta
                      mostrarMensaje('Respuesta correcta', Colors.green);
                      puntaje += (totalPuntos ~/ preguntas.length);
                    } else {
                      // Respuesta incorrecta
                      mostrarMensajeConExplicacion(
                        'Respuesta incorrecta',
                        Colors.red,
                        preguntas[indexPregunta].respuestaCorrecta,
                        preguntas[indexPregunta].explicacion,
                      );
                    }

                    // Cambiar a la siguiente pregunta después de responder
                    if (indexPregunta < preguntas.length - 1) {
                      indexPregunta++;
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
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
          title: Text(mensaje, style: TextStyle(color: color)),
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

List<Pregunta> obtenerPreguntasModulo3() {
  return [
    Pregunta(
      pregunta: '¿Cuáles son los síntomas comunes de asfixia y atragantamiento?',
      opciones: [
        'Dolor en el pecho y dificultad para tragar.',
        'Incapacidad para hablar o dificultad para respirar.',
        'Sensación de ardor en la garganta.',
        'Mareos y visión borrosa.',
      ],
      respuestaCorrecta: 'Incapacidad para hablar o dificultad para respirar.',
      explicacion:
          'Los síntomas comunes de asfixia y atragantamiento incluyen la incapacidad para hablar o dificultad para respirar. '
          'Estos signos indican que las vías respiratorias pueden estar bloqueadas por un objeto extraño.',
    ),
    Pregunta(
      pregunta: '¿Cuál es el paso inicial para tratar a alguien que está atragantándose?',
      opciones: [
        'Administrar medicamentos.',
        'Aplicar compresiones abdominales (maniobra de Heimlich).',
        'Realizar masajes cardiacos.',
        'Darle agua para tragar.',
      ],
      respuestaCorrecta: 'Aplicar compresiones abdominales (maniobra de Heimlich).',
      explicacion:
          'El paso inicial para tratar a alguien que está atragantándose es aplicar compresiones abdominales utilizando la maniobra de Heimlich. '
          'Esta técnica ayuda a expulsar el objeto extraño de las vías respiratorias.',
    ),
    Pregunta(
      pregunta: 'Si una persona pierde el conocimiento debido a la asfixia, ¿cuál es la siguiente acción recomendada?',
      opciones: [
        'Administrar más compresiones abdominales.',
        'Iniciar la reanimación cardiopulmonar (RCP).',
        'Esperar a que recupere el conocimiento.',
        'Darle agua inmediatamente.',
      ],
      respuestaCorrecta: 'Iniciar la reanimación cardiopulmonar (RCP).',
      explicacion:
          'Si una persona pierde el conocimiento debido a la asfixia, la siguiente acción recomendada es iniciar la reanimación cardiopulmonar (RCP). '
          'La RCP ayuda a mantener el flujo sanguíneo y la oxigenación hasta que llegue ayuda profesional.',
    ),
  ];
}
