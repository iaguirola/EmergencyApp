import 'package:emergencyapp/componentes/botones.dart';
import 'package:emergencyapp/componentes/cuadrado.dart';
import 'package:emergencyapp/componentes/textfield.dart';
import 'package:emergencyapp/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controladores de texto
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();

  // Función para iniciar sesión
  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context){
        return Center(
        child: CircularProgressIndicator(),
      );
      } 
    );

    try {
      if(passwordController.text == confirmPassword.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      }else{

        wrongPasswordMessage();
      }

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
        backgroundColor: Colors.deepPurple,
          title: Text('Correo Incorrecto',
          style: TextStyle(color: Colors.white),)
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
        backgroundColor: Colors.deepPurple,
          title: Text('Contraseña Incorrecta',
          style: TextStyle(color: Colors.white))
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
                  'Crear cuenta',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
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

                // Contraseña confirmar
                MyTextField(
                  controller: confirmPassword,
                  hintText: 'Confirmar Contraseña',
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
                  onTap: signUserUp,
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
                      onTap: () => AuthService().signInWithGoogle(),
                      image: 'G'),

                    const SizedBox(width: 25),

                    SquareTitle(
                      onTap: () {
                        
                      },
                      image: 'A'),
                  ],
                ),
          
                const SizedBox(height: 50),
          
                // No eres miembro - Registrarse ahora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ya tienes una cuenta',
                      style: TextStyle(color: Colors.grey[700],
                      fontFamily: 'Rowdies'),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Iniciar ahora',
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


