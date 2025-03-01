import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/helpers/services/local/db_helper.dart';
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

  void insertData() async {
    Map<String,dynamic> notes = {
      DatabaseHelper.columnTitle: "Learning",
      DatabaseHelper.columnSubtitle: "Learn React & Flutter"
    };
    final id = await dbHelper.insert(notes);
    print('Notes added with ID: ${id}');
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          insertData();
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: HexColor('#F8EEE2'),
        child: BlocConsumer<NotesBloc,NotesState>(
          bloc: notesBloc,
            builder: (context,state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Text('ADD NOTES')
                  ],
                ),
              );
            },
            listener: (BuildContext context, NotesState state) {}
        ),
      ),
    );
  }
}
