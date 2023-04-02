import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/cubit/auth_cubit.dart';
import 'package:new_project/page/all_notes.dart';
import 'package:new_project/page/main_page.dart';
import 'package:new_project/page/notes_create.dart';
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
      initialRoute: '/sign_in',
      routes: {
        '/sign_in': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const SignIn(),
            ),
        '/sign_up': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const SignUp(),
            ),
        '/main_page': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const MainPage(),
            ),
        '/all_notes': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const AllNotes(),
            ),
        '/note_edit': (_) => BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: const NotesCreate(),
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
