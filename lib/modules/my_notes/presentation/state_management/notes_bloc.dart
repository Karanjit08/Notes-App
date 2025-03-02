import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_note_app/modules/my_notes/data/notes_model.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<MyNotesInitialEvent>(myNotesInitialEvent);
    on<MyNotesNavigatetoNotesDisplayScreenEvent>(myNotesNavigatetoNotesDisplayScreenEvent);
    on<MyNotesNavigatetoAddNotesScreenEvent>(myNotesNavigatetoAddNotesScreenEvent);
  }

  FutureOr<void> myNotesInitialEvent(MyNotesInitialEvent event, Emitter<NotesState> emit) {
    print('My Notes Initial State emitted');
    if(event.notes.length > 0){
      emit(MyNotesNavigatetoNotesDisplayScreenState());
    }
    else {
      emit(MyNotesInitialState());
    }
  }

  FutureOr<void> myNotesNavigatetoNotesDisplayScreenEvent(MyNotesNavigatetoNotesDisplayScreenEvent event, Emitter<NotesState> emit) {
    print('MyNotesNavigatetoNotesDisplayScreenState emitted');
    emit(MyNotesNavigatetoNotesDisplayScreenState());
  }

  FutureOr<void> myNotesNavigatetoAddNotesScreenEvent(MyNotesNavigatetoAddNotesScreenEvent event, Emitter<NotesState> emit) {
    print('MyNotesNavigatetoAddNotesScreenState emitted');
    emit(MyNotesNavigatetoAddNotesScreenState());
  }
}
