import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../text_field_obscure.dart';
import '../user.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Изменение профиля',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(right: 300, bottom: 7, left: 300),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 28,
                ),
                maxLength: 30,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Не должно быть пустым';
                  }
                  if (value.length < 5) {
                    return 'Почта не менее 5 символов';
                  }
                  if (!RegExp("^(?=.*[a-z])").hasMatch(value)) {
                    return 'Почта должна содержать только латинские буквы';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Почта',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 300, bottom: 7, left: 300),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 28,
                ),
                maxLength: 30,
                controller: _loginController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Не должно быть пустым';
                  }
                  if (value.length < 5) {
                    return 'Логин должен быть не менее 5 символов';
                  }
                  if (!RegExp("^(?=.*[a-z])").hasMatch(value)) {
                    return 'Логин должен содержать только латинские буквы';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Логин',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 300, bottom: 7, left: 300),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 28,
                ),
                maxLength: 22,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Не должно быть пустым';
                  }
                  if (value.length < 8) {
                    return 'Пароль должен быть не меньше 8 символов';
                  }
                  if (!RegExp("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])")
                      .hasMatch(value)) {
                    return 'Пароль должен содержать заглавные и строчные буквы, а также цифры';
                  }
                  return null;
                },
                obscureText: isObscure,
                decoration: InputDecoration(
                  hintText: 'Пароль',
                  suffixIcon: TextFieldObscure(isObscure: (value) {
                    setState(() {
                      isObscure = value;
                    });
                  }),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 400, top: 30, left: 400),
                child: ElevatedButton(
                  child: const Text("Изменить"),
                  onPressed: () async {
                    User user = User(
                      userName: _loginController.text,
                      email: _emailController.text,
                    );
                    User result = await context.read<AuthCubit>().UpdateProfile(user, args);
                  },
                )),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_in');
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), padding: const EdgeInsets.all(15)),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ],
        ));
        
  }
}
