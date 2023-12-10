import 'package:emergencychat/componentes/my_button.dart';
import 'package:emergencychat/componentes/my_text_field.dart';
import 'package:emergencychat/services/auth/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final authService = Provider.of<AuthService>(context,listen:false);

    try{
      await authService.signInWithEmailandPassword(
        emailController.text,
        passwordController.text
      );

    }catch(e){
      ScaffoldMessenger.of( context).showSnackBar(SnackBar(content: Text(e.toString(),),),);

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                  
                //logo
                Icon(Icons.message,
                size: 100,
                color: Colors.grey[800],
                ),
                
                const SizedBox(height: 50,),
                  
                //welcome back
                const Text("Emergency Chat",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rowdies'
                  ),
                ),
                const SizedBox(height: 25,),
                  
                //email textfiled
                MyTextField(controller: emailController, 
                hintText: 'Correo electrónico', 
                obscureText: false
                ),

                const SizedBox(height: 10,),
                  
                  
                //password
                MyTextField(controller: passwordController,
                hintText: 'Contraseña', 
                obscureText: true),

                const SizedBox(height: 25,),
                

                //sing in
                MyButton(onTap: signIn, text: "Ingresar"),

                const SizedBox(height: 50,),
                  
                // not a member? register now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text('Registrate ahora',
                    style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rowdies',
                     ),
                     ),
                  ),
                ],)
                  
                  
                  
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}