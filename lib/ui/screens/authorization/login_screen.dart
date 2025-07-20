import 'package:flutter/material.dart';
import 'package:new_wild/services/helpers.dart';

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
                        //Логика валидации ташего текста
                        _formKey.currentState!.validate();
                      },
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //Логика валидации ташего текста
                        _formKey.currentState!.validate();
                      },
                      child: const Text('Register'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                    onPressed: () {}, child: const Text('Forgot password'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
