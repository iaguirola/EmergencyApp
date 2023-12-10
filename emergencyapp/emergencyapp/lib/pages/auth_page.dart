import 'package:emergencyapp/pages/loginregister.dart';
import 'package:emergencyapp/screens/inicio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // El usuario ha iniciado sesión
            final user = snapshot.data;
            
            // Muestra el SnackBar al iniciar sesión
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('¡Bienvenido, ${user?.email}!'),
                  duration: Duration(seconds: 2),
                ),
              );
            });

            return Inicio();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
