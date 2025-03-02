import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/helpers/services/local/db_helper.dart';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/pages/my_notes_display_screen.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/state_management/notes_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class MyNotesAddScreen extends StatefulWidget {
  const MyNotesAddScreen({super.key});

  @override
  State<MyNotesAddScreen> createState() => _MyNotesAddScreenState();
}

class _MyNotesAddScreenState extends State<MyNotesAddScreen> {
  final NotesBloc notesBloc = NotesBloc();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  void insertData(String title, String description) async {
    NotesModel notesModel =
    NotesModel(title: title, subtitle: description);
    final id = await dbHelper.insert(notesModel);
    print('Notes added with ID: ${id}');
    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#F8EEE2'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.delete,
                color: HexColor('#d9614c'),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor('#d9614c'),
            onPressed: () {
              print('Title: ${titleController.text}');
              print('Description: ${descriptionController.text}');
              insertData(titleController.text, descriptionController.text);
              titleController.clear();
              descriptionController.clear();
              notesBloc.add(MyNotesNavigatetoNotesDisplayScreenEvent());
            },
            child: Icon(Icons.save)),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: HexColor('#F8EEE2'),
          child: BlocConsumer(
              bloc: notesBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: TextField(
                        controller: titleController,
                        maxLines: null,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w600),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 30),
                            hintText: 'Add Title',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.black26,
                              ),
                            )),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      child: TextField(
                        controller: descriptionController,
                        maxLines: null,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 30),
                          hintText: 'Add Description',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ))
                  ],
                );
              },
              listener: (BuildContext context, NotesState state) {
                switch (state.runtimeType) {
                  case MyNotesNavigatetoNotesDisplayScreenState:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyNotesDisplayScreen()));
                }
              }),
        ));
  }
}
