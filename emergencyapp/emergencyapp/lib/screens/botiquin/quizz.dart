import 'package:flutter/material.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int score = 0;
  int questionIndex = 0;

  List<Question> questions = [
    Question(
      "¿Qué debes hacer primero en caso de quemadura?",
      ["Enjuagar con agua fría", "Aplicar hielo", "Aplicar mantequilla", "Nada"],
      0,
    ),
    Question(
      "¿Cuál es la posición correcta para alguien que se está ahogando?",
      ["Boca arriba", "Boca abajo", "De lado", "Parado"],
      2,
    ),
    Question(
      "¿Qué hacer si alguien tiene una convulsión?",
      ["Poner un palo en la boca", "Sujetar con fuerza", "Colocar en un lugar seguro", "Nada"],
      2,
    ),
    Question(
      "¿Cuál es la maniobra de Heimlich?",
      ["Golpear la espalda", "Compresiones en el pecho", "Presionar la cabeza", "Presionar el abdomen"],
      3,
    ),
    Question(
      "¿Cómo se debe detener una hemorragia?",
      ["Presionar con un pañuelo", "Dejar que sangre libremente", "Aplicar una venda apretada", "Gritar por ayuda"],
      0,
    ),
    Question(
      "¿Cuál es la posición correcta para realizar RCP?",
      ["Boca arriba", "Boca abajo", "De lado", "De pie"],
      0,
    ),
    Question(
      "En caso de fractura, ¿qué debes hacer antes de inmovilizar?",
      ["Dar un masaje", "Administrar medicamentos", "Reducir la inflamación", "Poner la extremidad en posición natural"],
      3,
    ),
    Question(
      "¿Cuál es el protocolo para ayudar a alguien que se está atragantando?",
      ["Golpear en la espalda", "Realizar compresiones abdominales", "Dar una palmada en la espalda", "Ninguna de las anteriores"],
      1,
    ),
    Question(
      "¿Qué se debe hacer si alguien tiene una quemadura química?",
      ["Aplicar aceite", "Enjuagar con agua", "Aplicar hielo", "Dejar secar al aire"],
      1,
    ),
    Question(
      "¿Cuál es la maniobra adecuada para detener una hemorragia en un brazo?",
      ["Elevar el brazo", "Aplicar presión directa", "Realizar compresiones en el brazo", "Inmovilizar el brazo"],
      1,
    ),
    // Nuevas preguntas
    Question(
      "¿Cuál es el tratamiento recomendado para una herida superficial?",
      ["Aplicar una venda apretada", "Lavar con agua y jabón", "Presionar para detener la hemorragia", "Aplicar hielo"],
      1,
    ),
    Question(
      "¿Qué elemento es esencial en un botiquín de primeros auxilios?",
      ["Pañuelos de papel", "Cinta adhesiva", "Tijeras", "Vendajes estériles"],
      3,
    ),
    Question(
      "¿Cuál es el paso inicial en el tratamiento de una fractura?",
      ["Inmovilizar la zona afectada", "Aplicar hielo", "Realizar masajes en la zona", "Dar un masaje cardíaco"],
      0,
    ),
    Question(
      "En caso de mordedura de insecto, ¿qué debes hacer?",
      ["Aplicar hielo", "Aspirar el veneno", "Lavar con agua y jabón", "Dejar la herida al aire"],
      2,
    ),
    Question(
      "¿Cuál es la posición adecuada para ayudar a alguien con una lesión en la espalda?",
      ["Boca arriba", "Boca abajo", "De pie", "No mover a la persona"],
      3,
    ),
  ];

  void answerQuestion(int selectedOption) {
    bool isCorrect = selectedOption == questions[questionIndex].correctAnswer;

    if (isCorrect) {
      setState(() {
        score += 100 ~/ questions.length;
      });
    }

    showMessage(isCorrect ? "¡Respuesta Correcta!" : "Respuesta Incorrecta. Pierdes puntos", isCorrect);

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
      });
    } else {
      showMessage("Has completado el cuestionario. Puntuación: $score/100", isCorrect, true);
    }
  }

  void showMessage(String message, bool isCorrect, [bool isFinal = false]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(
              color: isCorrect ? Colors.green : Colors.red,
              fontSize: isFinal ? 24.0 : 18.0,
              fontWeight: isFinal ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Rowdies',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cerrar",
                style: TextStyle(fontFamily: 'Rowdies'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cuestionario de Primeros Auxilios",
          style: TextStyle(fontFamily: 'Rowdies'),
          
        ),
        backgroundColor: Color(0xFFB8D2E4),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pregunta ${questionIndex + 1}: ${questions[questionIndex].questionText}",
              style: TextStyle(fontFamily: 'Rowdies', fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...questions[questionIndex]
                .options
                .asMap()
                .entries
                .map((entry) => OptionButton(
                      optionText: entry.value,
                      onPressed: () {
                        answerQuestion(entry.key);
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

class OptionButton extends StatelessWidget {
  final String optionText;
  final Function onPressed;

  OptionButton({required this.optionText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF34797B), // Color de fondo del botón
          padding: EdgeInsets.all(20.0), // Espaciado interno del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Bordes redondeados del botón
          ),
          minimumSize: Size(double.infinity, 0),
        ),
        child: Text(
          optionText,
          style: TextStyle(
            fontFamily: 'Rowdies',
          ),
        ),
      ),
    );
  }
}
