// lib/modulo2.dart

import 'package:flutter/material.dart';

class Modulo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 2', style: TextStyle(fontFamily: 'Rowdies'),),
      ),
      body: Modulo2Contenido(),
    );
  }
}

class Modulo2Contenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contenido del Módulo 2 - Primeros Auxilios',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'), // Aplicar fuente de letra
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            'Tema: Manejo de Emergencias y Resucitación',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Fracturas Expuestas'),
          _buildSeccionContenido(
            'En situaciones donde se presente una fractura expuesta, es fundamental realizar una inmovilización cuidadosa de la zona afectada. Utiliza un material acolchado para evitar movimientos bruscos que puedan empeorar la lesión. Además, es crucial solicitar asistencia médica de emergencia de inmediato para garantizar una atención profesional y especializada.'
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('RCP (Resucitación Cardiopulmonar)'),
          _buildSeccionContenido(
            'Cuando te encuentras con una persona inconsciente y que no está respirando, la prioridad es realizar compresiones torácicas. Esto implica aplicar presión rítmica en el centro del pecho a un ritmo de al menos 100-120 compresiones por minuto. Entre las compresiones, realiza ventilaciones de rescate cada 30 compresiones. Esta técnica, conocida como RCP (resucitación cardiopulmonar), debe continuarse hasta que llegue ayuda profesional o la víctima recupere la respiración. Recuerda seguir las pautas actuales de RCP para una eficacia óptima.'
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Modulo2Preguntas()),
              );
            },
            child: Text('Ir a las preguntas', style: TextStyle(color: Colors.white, fontFamily: 'Rowdies')), // Cambiar color del texto del botón
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Cambiar color del fondo del botón
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeccionTitulo(String titulo) {
    return Text(
      titulo,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'), // Aplicar fuente de letra
    );
  }

  Widget _buildSeccionContenido(String contenido) {
    return Text(
      contenido,
      style: TextStyle(fontSize: 16.0),
      textAlign: TextAlign.justify, // Aplicar justificación
    );
  }
}


class Modulo2Preguntas extends StatefulWidget {
  @override
  _Modulo2PreguntasState createState() => _Modulo2PreguntasState();
}

class _Modulo2PreguntasState extends State<Modulo2Preguntas> {
  List<Pregunta> preguntas = obtenerPreguntasModulo2();
  int indexPregunta = 0;
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
                      mostrarMensaje('Respuesta correcta', Colors.green);
                      puntaje += (totalPuntos ~/ preguntas.length);
                    } else {
                      mostrarMensajeConExplicacion(
                        'Respuesta incorrecta',
                        Colors.red,
                        preguntas[indexPregunta].respuestaCorrecta,
                        preguntas[indexPregunta].explicacion,
                      );
                    }

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
  String? respuestaSeleccionada;
  final String respuestaCorrecta;
  final String explicacion;

  Pregunta({
    required this.pregunta,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
  });
}

List<Pregunta> obtenerPreguntasModulo2() {
  return [
    Pregunta(
      pregunta: 'En caso de una fractura expuesta, es crucial _______________ de la zona afectada utilizando un material acolchado para evitar movimientos bruscos que puedan empeorar la lesión, mientras se solicita asistencia médica de emergencia.',
      opciones: [
        'realizar una aplicación de hielo',
        'realizar una inmovilización cuidadosa',
        'realizar una compresión cuidadosa',
        'realizar una estabilización cuidadosa'
      ],
      respuestaCorrecta: 'realizar una inmovilización cuidadosa',
      explicacion: 
          'En situaciones donde se presente una fractura expuesta, es fundamental realizar una inmovilización cuidadosa de la zona afectada. Utiliza un material acolchado para evitar movimientos bruscos que puedan empeorar la lesión. Además, es crucial solicitar asistencia médica de emergencia de inmediato para garantizar una atención profesional y especializada.',
    ),
    Pregunta(
      pregunta: 'Si te encuentras con una persona inconsciente y no respira, la prioridad es realizar _______________ a un ritmo de al menos _______________ por minuto, intercalando ventilaciones de rescate cada _______________ , hasta que llegue ayuda profesional o la víctima recupere la respiración.',
      opciones: [
        'maniobras de resucitación cardiopulmonar (RCP) / 110-130 / 50 compresiones',
        'masajes cardiacos / 120-150 / 40 compresiones',
        'compresiones torácicas / 100-120 / 30 compresiones',
        'ciclos de compresiones y ventilaciones de cierta cadencia / 100-130 / 20 compresiones'

      ],
      respuestaCorrecta: 'compresiones torácicas / 100-120 / 30 compresiones',
      explicacion:
          'Cuando te encuentras con una persona inconsciente y que no está respirando, la prioridad es realizar compresiones torácicas. Esto implica aplicar presión rítmica en el centro del pecho a un ritmo de al menos 100-120 compresiones por minuto. Entre las compresiones, realiza ventilaciones de rescate cada 30 compresiones. Esta técnica, conocida como RCP (resucitación cardiopulmonar), debe continuarse hasta que llegue ayuda profesional o la víctima recupere la respiración. Recuerda seguir las pautas actuales de RCP para una eficacia óptima.',
    ),
    // ... Otras preguntas aquí ...
  ];
}
