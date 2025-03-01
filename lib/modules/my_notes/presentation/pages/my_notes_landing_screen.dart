import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    notesBloc.add(MyNotesInitialEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: HexColor('#F8EEE2'),
        child: BlocConsumer<NotesBloc,NotesState>(
          bloc: notesBloc,
            builder: (context,state) {
              switch(state) {
                case MyNotesInitialState _:
                  return _buildMyNotesLandingState(state);
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
    return Text('Create your First Note',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 24),);
  }
  
  Widget _buildSubtitleText() {
    return Text('Add a note about anything',style: TextStyle(
      color: HexColor('#595550'),
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
                backgroundColor: HexColor('#d9614c')
            ),
            child: Text('Create a Note',style: TextStyle(
                color: HexColor('#fffbfa'),
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),)),
      ),
    );
  }
}
