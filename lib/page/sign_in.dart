import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/cubit/auth_cubit.dart';
import 'package:new_project/page/main_page.dart';
import 'package:new_project/page/sign_up.dart';

import '../custom_button.dart';
import '../text_field_obscure.dart';
import '../user.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;
  bool _isValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _key,
                child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                  if (state is ErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                }, builder: (context, state) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(child: SizedBox()),
                        const Text(
                          'Авторизация',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
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
                              if (!_isValid) {
                                return null;
                              }
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
                              labelText: 'Логин',
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
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Пароль',
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
                          child: CustomButton(
                            content: 'Войти',
                            onPressed: () async {
                              User user = User(
                        userName: _loginController.text,
                        password: _passwordController.text,
                      );

                      User result =
                          await context.read<AuthCubit>().SignIn(user);

                      if (result != null &&
                          context.read<AuthCubit>().state is SuccesState) {
                        Navigator.pushNamed(
                          context,
                          '/all_notes',
                          arguments: result,
                        );
                      } else {
                        // handle error or show loading indicator
                      }
                            },
                          ),
                        ),
                        const Expanded(flex: 3, child: SizedBox()),
                        InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            _loginController.clear();
                            _passwordController.clear();
                            _isValid = false;
                            _key.currentState!.validate();
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/sign_up');
                                  },
                                  child: const Text('Регистрация'))),
                        ),
                      ]);
                }))),
      ),
    );
  }

  // Future<void> signIn() async {
  //   await Dio().post(
  //     'http://127.0.0.1:8888/token',
  //     data: User(
  //         userName: _loginController.text, password: _passwordController.text),
  //   );
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (_) => const MainPage()));
  // }
}
