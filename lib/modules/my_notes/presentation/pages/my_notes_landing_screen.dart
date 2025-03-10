import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/helpers/services/local/db_helper.dart';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/pages/my_notes_display_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../state_management/notes_bloc.dart';



class MyNotesLandingScreen extends StatefulWidget {
  const MyNotesLandingScreen({super.key});

  @override
  State<MyNotesLandingScreen> createState() => _MyNotesLandingScreenState();
}

class _MyNotesLandingScreenState extends State<MyNotesLandingScreen> {

  final NotesBloc notesBloc = NotesBloc();
  final dbHelper = DatabaseHelper.instance;
  List<NotesModel> allNotes = [];

  Future<int> queryAll() async {
    allNotes = (await dbHelper.queryAll())!;
    print(allNotes.length);
    notesBloc.add(MyNotesInitialEvent(notes: allNotes));
    return allNotes.length;
  }
  @override
  void initState() {
    super.initState();
    queryAll();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.surface,
        child: BlocConsumer<NotesBloc,NotesState>(
          bloc: notesBloc,
            builder: (context,state) {
              switch(state) {
                case MyNotesInitialState _:
                  return _buildMyNotesLandingState(state);
                case MyNotesNavigatetoNotesDisplayScreenState _:
                  return MyNotesDisplayScreen();
                default:
                  return SizedBox();
              }
            },
            listener: (BuildContext context, NotesState state) {
              switch(state.runtimeType) {
                case MyNotesNavigatetoNotesDisplayScreenState:
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MyNotesDisplayScreen()));
              }
            }
        ),
      ),
    );
  }

  Widget _buildMyNotesLandingState(MyNotesInitialState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 250,),
          _buildIllustrationImage(),
          SizedBox(height: 50,),
          _buildTitleText(),
          SizedBox(height: 15,),
          _buildSubtitleText(),
          SizedBox(height: 80,),
          _buildCreateNoteBtn()
        ],
      )
    );
  }

  Widget _buildIllustrationImage() {
    return Center(
        child: Image.asset('assets/images/png/notes_landing_illustration.png')
    );
  }

  Widget _buildTitleText() {
    return Text('Create your First Note',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24,color: Theme.of(context).colorScheme.primary),);
  }
  
  Widget _buildSubtitleText() {
    return Text('Add a note about anything',style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold
    ),
    );
  }

  Widget _buildCreateNoteBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: (){
          notesBloc.add(MyNotesNavigatetoNotesDisplayScreenEvent());
        },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer
            ),
            child: Text('Create a Note',style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),)),
      ),
    );
  }

}
