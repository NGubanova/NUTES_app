import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../note.dart';
import '../query.dart';
import '../transfer.dart';
import '../user.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({Key? key}) : super(key: key);

  @override
  State<AllNotes> createState() => _AllNotesState();
}


class _AllNotesState extends State<AllNotes> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    TextEditingController txtFilter = TextEditingController();
    final args = ModalRoute.of(context)!.settings.arguments as User;
    List<Color> listColor = [
      Colors.red.shade900,
      Colors.orange.shade900,
      Colors.yellow.shade900,
      Colors.green.shade900,
      Colors.blue.shade900,
      Colors.purple.shade900
    ];
    int _widgetCount = 0;
    String token = args.token ?? "";
    final double skWidth = MediaQuery.of(context).size.width;
    final double skHeight = MediaQuery.of(context).size.height;
    var dio = Dio();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(4),
                width: skWidth * 0.7,
                height: skHeight * 0.07,
                child: TextField(
                  controller: txtFilter,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Категория',
                  ),
                ),
              ),
              
            ],
          ),
          SizedBox(
            height: skHeight * 0.7,
            child: FutureBuilder<List<Note>>(
              future: QQuery(dio).getAllNotes(token),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    _widgetCount++;
                    Note note = snapshot.data![index];
                    return ListTile(
                      onLongPress: () {
                        Navigator.pushNamed(
                              context,
                              '/note_edit',
                              arguments: Transfer(note, args.token!),
                            );
                      },
                      title: Container(
                        decoration: BoxDecoration(
                          color: listColor[_widgetCount % 6],
                          border: Border.all(
                              width: 2, color: listColor[_widgetCount % 6]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Text(
                                  '${note.nameNote}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Container(margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Text('${note.content}'),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Text('Категория: ${note.category}'),
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: Text(
                                'Дата создания: ${DateFormat('dd.MM.yyyy hh:mm').format(note.dateCreation!)}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            note.dateEdit == note.dateCreation
                                ? Container()
                                : Container(
                                    alignment: Alignment.bottomRight,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: Text(
                                      'Дата изменения: ${DateFormat('dd.MM.yyyy hh:mm').format(note.dateEdit!)}',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      )),
    );
  }
  }