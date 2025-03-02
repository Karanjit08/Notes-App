import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/helpers/services/local/db_helper.dart';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/pages/my_notes_add_screen.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/state_management/notes_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class MyNotesDisplayScreen extends StatefulWidget {
  const MyNotesDisplayScreen({super.key});

  @override
  State<MyNotesDisplayScreen> createState() => _MyNotesDisplayScreenState();
}

class _MyNotesDisplayScreenState extends State<MyNotesDisplayScreen> {
  final NotesBloc notesBloc = NotesBloc();
  final dbHelper = DatabaseHelper.instance;


  Future<List<NotesModel>> getAllNotes() async {
    return await dbHelper.queryAll() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#d9614c'),
        onPressed: () {
          notesBloc.add(MyNotesNavigatetoAddNotesScreenEvent());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: HexColor('#F8EEE2'),
        child: BlocConsumer<NotesBloc, NotesState>(
            bloc: notesBloc,
            builder: (context, state) {
              return FutureBuilder<List<NotesModel>>(
                  future: getAllNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Notes Available',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            NotesModel note = snapshot.data![index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: ListTile(
                                title: Text(note.title ?? "Untitled"),
                                subtitle: Text(note.subtitle ?? ""),
                              ),
                            );
                          });
                    }
                  });
            },
            listener: (BuildContext context, NotesState state) {
              switch(state.runtimeType) {
                case MyNotesNavigatetoAddNotesScreenState:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyNotesAddScreen()));
              }
            }),
      ),
    );
  }
}
