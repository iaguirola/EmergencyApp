import 'package:emergencyapp/componentes/botones.dart';
import 'package:emergencyapp/componentes/cuadrado.dart';
import 'package:emergencyapp/componentes/textfield.dart';
import 'package:emergencyapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores de texto
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // Función para iniciar sesión
  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context){
        return const Center(
        child: CircularProgressIndicator(),
      );
      } 
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }

    
  }

  // Mostrar mensaje de correo incorrecto
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return
        const AlertDialog(
        title: Text('Correo Incorrecto'),
      );

      },
    );
  }

  // Mostrar mensaje de contraseña incorrecta
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return
        const AlertDialog(
        title: Text('Contraseña Incorrecta'),
        );

      }
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
          
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
          
                // Bienvenida
                const SizedBox(height: 25),
                Text(
                  'Bienvenido',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16,fontFamily: 'Rowdies'),
                ),
          
                const SizedBox(height: 25),
          
                // Usuario
                MyTextField(
                  controller: usernameController,
                  hintText: 'Usuario',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // Contraseña
                MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),
          
                // Olvidaste la contraseña
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Olvidaste la contraseña',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Rowdies',
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // Botón de inicio de sesión
                MyButton(
                  onTap: signUserIn,
                ),
          
                // O continuar con
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Conectarse con',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: 'Rowdies',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
          
                // Google + Apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTitle(
                      onTap: () => AuthService().signInWithGoogle() ,
                      image: 'G'),
                    const SizedBox(width: 25),
                    SquareTitle(
                      onTap: () {} ,
                      image: 'A'),
                  ],
                ),
          
                const SizedBox(height: 50),
          
                // No eres miembro - Registrarse ahora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No eres miembro',
                      style: TextStyle(color: Colors.grey[700], fontFamily: 'Rowdies'),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Registrarse ahora',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rowdies',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
