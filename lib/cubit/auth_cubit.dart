import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_project/app_env.dart';
import 'package:new_project/page/sign_in.dart';

import '../user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.dio) : super(InitalState());

  final Dio dio;

  Future<void> SignUp(User user) async {
    try {
      var result =
          await dio.put(AppEnv.protocol + AppEnv.ip + AppEnv.auth, data: user);
      var data = User.fromJson(result.data);
      if (result.statusCode == 200) {
        if (data.token == null) {
          throw DioError(
              requestOptions: RequestOptions(path: ''), error: 'нулевой токен');
        }
        emit(SuccesState());
      }
    } on DioError catch (e) {
      emit(ErrorState(e.response!.data['message']));
    }
  }

  Future<void> SignIn(User user) async {
    try {
      // var result = await dio.post(AppEnv.protocol+AppEnv.ip+AppEnv.auth, data: user);

      var result = await dio.post('https://127.0.0.1:8888/token', data: user);
      // var data =User.fromJson(result.data);
      // if (result.statusCode == 200) {
      //   if (data.token == null) {
      //     throw DioError(
      //         requestOptions: RequestOptions(path: ''), error: 'нулевой токен');
      //   }
      //   emit(SuccesState());
      // }
    } on DioError catch (e) {
      emit(ErrorState(e.response!.data['message']));
      print(e.response!.data);
      print(e.response!.statusCode);
      print(e.response!.statusMessage);

    }
  }
}
