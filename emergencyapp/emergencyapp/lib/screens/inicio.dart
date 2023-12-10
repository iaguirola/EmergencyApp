import 'package:emergencyapp/screens/botiquin/educativo.dart';
import 'package:emergencyapp/screens/microfono/speech.dart';
import 'package:emergencyapp/screens/navigation/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  //final user = FirebaseAuth.instance.currentUser!;

 /*  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Llama a la función de cerrar sesión al presionar el botón de logout
              //signUserOut(context);
            },
            icon: Icon(Icons.logout,
            color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 190),
                child: Text(
                  'Emergency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Rowdies',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rowdies',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Agrega cualquier otro widget que desees dentro del SingleChildScrollView
            ],
          ),
        ),
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 200),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Navigation()));
                      },
                      child: Icon(Icons.navigation),
                      backgroundColor: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text('Ubicación', style: TextStyle(fontFamily: 'Rowdies')),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Speech()));
                      },
                      child: Icon(Icons.mic),
                      backgroundColor: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text('Habla', style: TextStyle(fontFamily: 'Rowdies')),
                  ],
                ),
                Column(
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => educativo()));
                      },
                      child: Icon(Icons.local_hospital_outlined),
                      backgroundColor: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text('Educativo', style: TextStyle(fontFamily: 'Rowdies')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
