import 'package:flutter/material.dart';

class Modulo4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulo 4',
        style: TextStyle(fontFamily: 'Rowdies'),),
        backgroundColor: Color(0xFFB8D2E4)
      ),
      body: Modulo4Contenido(),
    );
  }
}

class Modulo4Contenido extends StatelessWidget {
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
            'Contenido del Módulo 4 - Quemaduras y Lesiones Químicas',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          Text(
            'Tema: Manejo Avanzado de Quemaduras y Lesiones Químicas',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Rowdies'),
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Quemaduras Químicas'),
          _buildSeccionContenido(
            'Las quemaduras químicas son lesiones en la piel causadas por sustancias químicas corrosivas. Es crucial actuar rápidamente en caso de exposición. Enjuague la zona afectada con agua abundante durante al menos 15 minutos para eliminar la sustancia química. Luego, aplique una solución neutralizante si está disponible y cubra la quemadura con un vendaje limpio.'
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Tipos de Quemaduras'),
          _buildSeccionContenido(
            'Existen diferentes tipos de quemaduras, clasificadas según la profundidad del daño tisular. Las quemaduras de primer grado afectan la capa externa de la piel, las de segundo grado afectan la epidermis y parte de la dermis, mientras que las de tercer grado penetran todas las capas de la piel y pueden afectar estructuras subyacentes.'
          ),
          SizedBox(height: 20.0),
          _buildSeccionTitulo('Manejo Inicial'),
          _buildSeccionContenido(
            'El manejo inicial de una quemadura incluye enfriar la zona afectada con agua fría, cubrir la quemadura con un vendaje limpio y buscar ayuda médica si es necesario. Evite el uso de hielo directo y no aplique ungüentos ni cremas hasta que un profesional de la salud lo evalúe.'
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImagenConMarcoNegro('assets/quimico.jpg'),
              _buildImagenConMarcoNegro('assets/quimica2.jpg'),
              _buildImagenConMarcoNegro('assets/quimico3.jpg'),
            ],
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Modulo4Preguntas()),
              );
            },
            child: Text('Ir a las preguntas', style: TextStyle(fontFamily: 'Rowdies'),),
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

class Modulo4Preguntas extends StatefulWidget {
  @override
  _Modulo4PreguntasState createState() => _Modulo4PreguntasState();
}

class _Modulo4PreguntasState extends State<Modulo4Preguntas> {
  List<Pregunta> preguntas = obtenerPreguntasModulo4();
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

List<Pregunta> obtenerPreguntasModulo4() {
  return [
    Pregunta(
      pregunta: '¿Cuáles son los síntomas comunes de quemaduras químicas?',
      opciones: [
        'Enrojecimiento y dolor leve.',
        'Ampollas y dolor intenso.',
        'Comezón temporal.',
        'Decoloración permanente de la piel.',
      ],
      respuestaCorrecta: 'Ampollas y dolor intenso.',
      explicacion:
          'Los síntomas comunes de quemaduras químicas incluyen la formación de ampollas y dolor intenso. '
          'Estos signos indican daño significativo en las capas de la piel y requieren atención médica inmediata.',
    ),
    Pregunta(
      pregunta: '¿Qué tipo de quemadura afecta todas las capas de la piel y puede afectar estructuras subyacentes?',
      opciones: [
        'Quemadura de primer grado.',
        'Quemadura de segundo grado.',
        'Quemadura de tercer grado.',
        'Quemadura química.',
      ],
      respuestaCorrecta: 'Quemadura de tercer grado.',
      explicacion:
          'Una quemadura de tercer grado afecta todas las capas de la piel y puede afectar estructuras subyacentes, como músculos y huesos. '
          'Este tipo de quemadura es grave y generalmente requiere atención médica especializada.',
    ),
    Pregunta(
      pregunta: '¿Cuál es el paso inicial para tratar quemaduras químicas en la piel?',
      opciones: [
        'Aplicar hielo directamente.',
        'Enjuagar con agua abundante durante al menos 15 minutos.',
        'Aplicar una crema hidratante.',
        'Permitir que la sustancia química se seque naturalmente.',
      ],
      respuestaCorrecta: 'Enjuagar con agua abundante durante al menos 15 minutos.',
      explicacion:
          'El paso inicial para tratar quemaduras químicas en la piel es enjuagar la zona afectada con agua abundante durante al menos 15 minutos. '
          'Esto ayuda a eliminar la sustancia química y reduce el daño causado por la misma.',
    ),
  ];
}
