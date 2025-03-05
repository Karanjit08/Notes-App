part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}


class MyNotesInitialEvent extends NotesEvent {
  List<NotesModel> notes;
  MyNotesInitialEvent({required this.notes});
}

class MyNotesNavigatetoNotesDisplayScreenEvent extends NotesEvent {}

class MyNotesNavigatetoAddNotesScreenEvent extends NotesEvent {}

