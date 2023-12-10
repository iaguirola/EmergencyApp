import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencyapp/screens/inicio.dart';
import 'package:emergencyapp/screens/microfono/colors.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({Key? key}) : super(key: key);

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();

  var text = "Mantén presionado el botón y habla";
  var isListening = false;
  var firebaseInfoTipo = "...........";
  var firebaseInfoQueHacer = "...........";
  bool _hasSpoken = false; // Variable para controlar si ya se ha hablado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Inicio()));
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFB8D2E4),
        elevation: 0.0,
        title: const Text(
          "Dime cuál es tu emergencia",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
            fontFamily: 'Rowdies',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 24,
                  color: isListening ? Colors.black : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rowdies',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "Tipo:",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rowdies',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                firebaseInfoTipo,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rowdies',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                "¿Qué hacer?",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rowdies',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                firebaseInfoQueHacer,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Rowdies',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: Duration(milliseconds: 2000),
        glowColor: bgColor,
        repeat: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });

                      print("Palabra reconocida: ${result.recognizedWords}");

                      consultarFirebase(result.recognizedWords);
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 35,
            child: Icon(isListening ? Icons.mic : Icons.mic_none, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> consultarFirebase(String palabra) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference collectionReferenceEstablecimiento = db.collection('Directorio');
    CollectionReference collectionReferenceEmergencia = db.collection('Emergencias');

    QuerySnapshot queryEstablecimiento = await collectionReferenceEstablecimiento.get();
    QuerySnapshot queryEmergencia = await collectionReferenceEmergencia.get();

    bool encontrada = false;

    queryEstablecimiento.docs.forEach((QueryDocumentSnapshot documento) {
      Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

      if (data != null && data['tipo'] != null && data['tipo'].toString().toLowerCase() == palabra.toLowerCase()) {
        setState(() {
          firebaseInfoTipo =
              "Nombre: ${data['detalles']['nombre']}, Dirección: ${data['detalles']['direccion']}, Teléfono: ${data['detalles']['telefono']}";
        });

        encontrada = true;
      }
    });

    queryEmergencia.docs.forEach((QueryDocumentSnapshot documento) {
      Map<String, dynamic>? data = documento.data() as Map<String, dynamic>?;

      if (data != null) {
        // Verificar si la palabra coincide directamente o si es un sinónimo
        String tipoEmergencia = data['tipo'].toString().replaceAll(' ', '').toLowerCase();
        String palabraLowerCase = palabra.replaceAll(' ', '').toLowerCase();

        if (tipoEmergencia == palabraLowerCase || 
            data['sinonimos'] != null && data['sinonimos'].contains(palabraLowerCase)) {
          setState(() {
            firebaseInfoTipo = "${data['tipo']}";
            firebaseInfoQueHacer = " ${data['¿Qué hacer?']}";
          });

          encontrada = true;

          // Reproducir texto a voz solo si no ha hablado antes
          if (!_hasSpoken) {
            _speak("Tipo: ${data['tipo']}. ¿Qué hacer? ${data['¿Qué hacer?']}");
            _hasSpoken = true; // Marcar como hablado
          }
        }
      }
    });

    if (!encontrada) {
      setState(() {
        firebaseInfoTipo = "Resultados no encontrados para '$palabra'";
        firebaseInfoQueHacer = "";
      });
    }
  }

  // Método para reproducir texto a voz
  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }
}
