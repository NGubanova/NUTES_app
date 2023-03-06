import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/cubit/auth_cubit.dart';
import 'package:new_project/page/sign_in.dart';

import '../custom_button.dart';
import '../text_field_obscure.dart';
import '../user.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _key = GlobalKey();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _key,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      const Text(
                        'Регистрация',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 300, bottom: 7, left: 300),
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
                        margin: const EdgeInsets.only(
                            right: 300, bottom: 7, left: 300),
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
                        margin: const EdgeInsets.only(
                            right: 300, bottom: 7, left: 300),
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
                        margin: const EdgeInsets.only(
                            right: 400, top: 30, left: 400),
                        child: ElevatedButton(
                    child: const Text("Зарегистрироваться"),
                    onPressed: () async {
                      User user = User(
                        userName: _loginController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      User result =
                          await context.read<AuthCubit>().SignUp(user);

                      if (result != null &&
                          context.read<AuthCubit>().state is SuccesState) {
                        Navigator.pushNamed(
                          context,
                          '/main_page',
                          arguments: result,
                        );
                      } else {
                        // handle error or show loading indicator
                      }
                    },
                  )
                      ),
                      const Spacer(flex: 2),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () {
                                    Navigator.pushNamed(context, '/sign_in');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(15)
                          ),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  void signUp() async {
    await Dio().put(
      'http://127.0.0.1:8888/token',
      data: User(
          userName: _loginController.text,
          email: _emailController.text,
          password: _passwordController.text),
    );
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()));
  }
}
