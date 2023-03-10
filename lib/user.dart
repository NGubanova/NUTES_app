import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String userName,
    String? email,
    String? password,
    @JsonKey(name: 'refreshToken') String? token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // factory User.toJson(_$_User instance) => _$UserToJson(instance);
}
