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

  final _httpClient = Dio();

  _onSearch(SearchUserEvent event, Emitter<NoteState> emit) async {
    if (event.query.length < 3) return;
    _httpClient.options.headers["Authorization"] = "Bear";
    final res = await _httpClient.get(
      AppEnv.protocol + AppEnv.ip + AppEnv.note, 
      // queryParameters: {
      //   'nameNote': event.query,
      // }, 
    );
    emit(NoteState(notes: res.data['data']));
  }

}
