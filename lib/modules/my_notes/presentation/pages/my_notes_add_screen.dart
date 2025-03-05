import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/helpers/services/local/db_helper.dart';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/pages/my_notes_display_screen.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/state_management/notes_bloc.dart';
import 'package:flutter_note_app/shared/widgets/custom_app_bar.dart';
import 'package:hexcolor/hexcolor.dart';

class MyNotesAddScreen extends StatefulWidget {
  int? id;
  String? title;
  String? description;
  MyNotesAddScreen({super.key, this.id, this.title, this.description});

  @override
  State<MyNotesAddScreen> createState() => _MyNotesAddScreenState();
}

class _MyNotesAddScreenState extends State<MyNotesAddScreen> {
  final NotesBloc notesBloc = NotesBloc();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  void insertData(String title, String description) async {
    NotesModel notesModel = NotesModel(title: title, subtitle: description);
    final id = await dbHelper.insert(notesModel);
    notesModel.id = id;
    print('Notes added with ID: ${id}');
    setState(() {});
  }

  void deleteData(int id) async {
    if (widget.id != null) {
      await dbHelper.delete(widget.id!);
      print('Note Deleted with ID: ${widget.id}');
      notesBloc.add(MyNotesNavigatetoNotesDisplayScreenEvent());
    } else {
      print('No ID found for deletion');
    }
  }

  void updateData(String title,String description) async {
    NotesModel notesModel = NotesModel(id: widget.id, title: title, subtitle: description);
    final id = await dbHelper.update(widget.id!, notesModel);
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title.toString();
    descriptionController.text = widget.description.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onBackPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MyNotesDisplayScreen()));
          },
          onDeletePressed: () {
            print('Delete Icon Clicked');
            deleteData(widget.id!);
          },
        ),
        floatingActionButton: _buildFloatingActionButton(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.surface,
          child: BlocConsumer(
              bloc: notesBloc,
              builder: (context, state) {
                return Column(
                  children: [
                    _buildTitleTextField(),
                    _buildDescriptionTextField()
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

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        onPressed: () {
          if(widget.id != null) {
            updateData(titleController.text, descriptionController.text);
          }
          else {
            print('Title: ${titleController.text}');
            print('Description: ${descriptionController.text}');
            insertData(titleController.text, descriptionController.text);
            titleController.clear();
            descriptionController.clear();
          }
          notesBloc.add(MyNotesNavigatetoNotesDisplayScreenEvent());
        },
        child: Icon(Icons.save,color: Theme.of(context).colorScheme.secondary,));
  }

  Widget _buildTitleTextField() {
    return SizedBox(
      child: TextField(
        controller: titleController,
        maxLines: null,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.primary),
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            hintText: 'Add Title',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )),
      ),
    );
  }

  Widget _buildDescriptionTextField() {
    return Expanded(
        child: Container(
      width: double.infinity,
      child: TextField(
        controller: descriptionController,
        maxLines: null,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onPrimary
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          hintText: 'Add Description',
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary
          ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    ));
  }
}
