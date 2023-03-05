import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'goto_state.dart';

class GotoCubit extends Cubit<GotoState> {
  GotoCubit() : super(GotoState.initial());
}
