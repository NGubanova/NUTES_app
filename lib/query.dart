import 'dart:convert';

import 'package:dio/dio.dart';

import 'note.dart';

class QQuery {
  QQuery(this.dio);
  Future<List<Note>> getAllNotes(String token) async {
    List<Note> listNote = [];
    // try {
    var result = await dio.get(
      "http://127.0.0.1:8888/note",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
      queryParameters: {
        "page": 0,
        "search": "",
      },
    );
    List<dynamic> jsonList = result.data;
    listNote = jsonList.map((json) => Note.fromJson(json)).toList();
    // } on DioError catch (e) {
    //   print(e.message);
    // }
    return listNote;
  }

  final Dio dio;
  Future<void> createNote(Note note, String token) async {
    try {
      var result = await dio.post(
        "http://127.0.0.1:8888/note",
        data: note.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioError catch (e) {
      print(e.message);
    }
  }

  Future<void> updateNote(Note note, String token) async {
    try {
      var result = await dio.put("http://127.0.0.1:8888/note/${note.id}",
          data: note.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token'}));
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
