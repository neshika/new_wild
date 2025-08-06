import 'package:flutter/material.dart';
import 'package:new_wild/services/auth.dart';
import 'package:new_wild/services/helpers.dart';
import 'package:new_wild/ui/screens/authorization/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //создаем контролер для Почты и пароля (проверять на валидность)
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  // создаем ключ, чтобы обращаться к нашей форме
  final _formKey = GlobalKey<FormState>();
  final authService = Auth();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, //все элементы растянуты по минимуму
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0), // линия под Велком
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true, //текст звездочки
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        //Логика валидации вашего текста
                        if (_formKey.currentState!.validate()) {
                          //Если валидация прошла, то логинимся
                          authService.signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Логика валидации вашего текста
                        if (_formKey.currentState!.validate()) {
                          //Если валидация прошла, то регистрируемся
                          authService.createUserWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text);
                        }
                      },
                      child: const Text('Register'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                    onPressed: () {
                      //Для перехода на линк
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: const Text('Forgot password'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
