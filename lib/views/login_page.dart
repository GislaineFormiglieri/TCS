import 'package:flutter/material.dart';
import 'package:invoice/components/my_input.dart';
import 'package:invoice/services/firebase_connect.dart';
import 'package:invoice/views/home_page.dart';
import 'package:invoice/views/passreset_page';
import 'package:invoice/views/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 206, 175),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/logo.png',
            height: 190.0,
            width: 190.0,
            fit: BoxFit.contain,
          ),
          MyInput(
            controller: emailController,
            placeholder: 'Email',
            type: false,
          ),
          MyInput(
            controller: passwordController,
            placeholder: 'Senha',
            type: true,
          ),
          ElevatedButton(
            onPressed: () async {
              var auth =
                  await login(emailController.text, passwordController.text);
              if (auth == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Usuário ou senha incorretos'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Text('Entrar'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
            child: Text('Cadastrar'),
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PasswordResetPage(),
                ),
              );
            },
            child: Text('Recuperar Senha', style: TextStyle(color: Colors.blue),)
          )
        ],
      ),
    );
  }
}
