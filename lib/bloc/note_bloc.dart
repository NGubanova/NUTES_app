import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_project/app_env.dart';
import 'package:stream_transform/stream_transform.dart';

part 'note_event.dart';
part 'note_state.dart';

EventTransformer<E> debounceDroppable<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration);
  };
}

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteState()) {
    on<SearchUserEvent>(_onSearch,
        transformer: debounceDroppable(Duration(seconds: 2)));
  }

  Dio dio = Dio();

  _onSearch(SearchUserEvent event, Emitter<NoteState> emit) async {
    String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9." +
        "eyJleHAiOjE2NzgxMTk5ODksImlhdCI6MTY3OD" +
        "ExNjM4OSwiaWQiOjl9.RUtBymgL7gGDPsVKNhtijh_cQ0O8GwXxs9d9uo7EaqU";
    dio.options.headers["Authorization"] = "Bearer $token";
    final res = await dio.get(
      AppEnv.protocol + AppEnv.ip + AppEnv.note,
      // queryParameters: {
      //   'nameNote': event.query,
      // },
    );
    emit(NoteState(notes: res.data['data']));
  }
}
