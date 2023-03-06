import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.dio) : super(InitalState());

  final Dio dio;

  Future<User> SignUp(User user) async {
    User userRet = const User(userName: '', email: '', password: '');

    try {
      var result = await dio.put("http://127.0.0.1:8888/token", data: user);
      var data = User.fromJson(result.data['data']);
      userRet = data;
      if (result.statusCode == 200) {
        throw DioError(
            requestOptions: RequestOptions(path: ''), error: 'нулевой токен');

        emit(SuccesState());
      }
    } on DioError catch (e) {
      emit(ErrorState(e.response!.data['message']));
    }
    return userRet;
  }

  Future<User> SignIn(User user) async {
    User userRet = const User(userName: '', password: '');
    try {
      var result = await dio.post(
        'http://127.0.0.1:8888/token',
        data: user,
        options: Options(responseType: ResponseType.json),
      );
      var data = User.fromJson(result.data['data']);
      userRet = data;
      if (result.statusCode == 200) {
        // throw DioError(
        //     requestOptions: RequestOptions(path: ''), error: 'нулевой токен');

        emit(SuccesState());
      }
    } on DioError catch (e) {
      emit(ErrorState(e.response!.data['message']));
    }
    return userRet;
  }

  Future<User> UpdateProfile(User user, User userToken) async {
    User userRet = const User(userName: '', email: '');

    String? token = userToken.token;
    try {
      var result = await dio.post("http://127.0.0.1:8888/user",
          data: user, 
          options: Options(
            headers: {'Authorization':'Bearer $token'}));
      var data = User.fromJson(result.data['data']);
      userRet = data;
      if (result.statusCode == 200) {
        emit(SuccesState());
      }
    } on DioError catch (e) {
      emit(ErrorState(e.response!.data['message']));
    }
    return userRet;
  }
}
