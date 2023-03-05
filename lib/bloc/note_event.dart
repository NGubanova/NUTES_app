part of 'note_bloc.dart';

class NoteEvent {}

class SearchUserEvent extends NoteEvent {
  final String query;

  SearchUserEvent(this.query);
}