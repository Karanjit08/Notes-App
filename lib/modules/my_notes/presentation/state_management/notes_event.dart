part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}


class MyNotesInitialEvent extends NotesEvent {}

class MyNotesNavigatetoNotesDisplayScreenEvent extends NotesEvent {}
