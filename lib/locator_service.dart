import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_project/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_env.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => AuthCubit(sl()));

  final sharedPreferences = SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio(BaseOptions(
        sendTimeout: 1500,
        connectTimeout: 1500,
        receiveTimeout: 1500,
        baseUrl: '${AppEnv.protocol}://${AppEnv.ip}',
      )));
}
