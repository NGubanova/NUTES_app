import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/bloc/note_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final notes = context.select((NoteBloc bloc)=> bloc.state.notes);
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(
        height: 20,
      ),
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Заметка',
          prefixIcon: Icon(Icons.search),
          border: const OutlineInputBorder(),
        ),
        onChanged: (value) {
            context.read<NoteBloc>().add(SearchUserEvent(value));
          },
        ),
        if (notes.isNotEmpty)
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]['noteName']),
                );
              },
              itemCount: notes.length,
      ))
    ]));
  }
}
