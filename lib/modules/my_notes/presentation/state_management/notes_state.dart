part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class MyNotesInitialState extends NotesState {}

class MyNotesNavigatetoNotesDisplayScreenState extends NotesState {}

class MyNotesNavigatetoAddNotesScreenState extends NotesState {}