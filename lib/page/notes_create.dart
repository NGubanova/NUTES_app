import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/transfer.dart';

import '../note.dart';
import '../query.dart';
import '../user.dart';

class NotesCreate extends StatefulWidget {
  const NotesCreate({Key? key}) : super(key: key);

  @override
  State<NotesCreate> createState() => _NotesCreateState();
}

class _NotesCreateState extends State<NotesCreate> {
  bool isObscure = true;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtNote = TextEditingController();
  TextEditingController txtCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Transfer;
    final double skWidth = MediaQuery.of(context).size.width;
    final double skHeight = MediaQuery.of(context).size.height;
    txtName.text = args.note.nameNote;
    txtNote.text = args.note.content;
    txtCategory.text = args.note.category;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final dio = Dio();
          final note = Note(
            nameNote: txtName.text,
            content: txtNote.text,
            category: txtCategory.text,
            id: args.note.id,
          );
          QQuery(dio).updateNote(note, args.token);
          setState(() {
            txtName.text = '';
            txtNote.text = '';
            txtCategory.text = '';
          });
        },
        child: Icon(Icons.add_circle_outline),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.deepOrange.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              width: skWidth * 0.9,
              height: skHeight * 0.07,
              child: TextField(
                controller: txtName,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Название',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.deepOrange.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              width: skWidth * 0.9,
              height: skHeight * 0.07,
              child: TextField(
                controller: txtNote,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Содержание',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.deepOrange.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              width: skWidth * 0.9,
              height: skHeight * 0.07,
              child: TextField(
                controller: txtCategory,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Категория',
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
