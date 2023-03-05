import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/cubit/auth_cubit.dart';
import 'package:new_project/page/main_page.dart';
import 'package:new_project/page/sign_in.dart';
import 'package:new_project/page/sign_up.dart';
import 'package:new_project/user.dart';

import 'locator_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main_page',
      routes: {
        '/sign_in': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: SignIn(),
            ),
        '/sign_up': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: SignUp(),
            ),
        '/main_page': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: MainPage(),
            ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
      ),
      themeMode: ThemeMode.light,
    );
  }
}