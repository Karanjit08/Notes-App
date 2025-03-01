part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}


class MyNotesInitialEvent extends NotesEvent {
  List<Map<String,dynamic>> notes;
  MyNotesInitialEvent({required this.notes});
}

class MyNotesNavigatetoNotesDisplayScreenEvent extends NotesEvent {}
