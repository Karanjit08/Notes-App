import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<MyNotesInitialEvent>(myNotesInitialEvent);
    on<MyNotesNavigatetoNotesDisplayScreenEvent>(myNotesNavigatetoNotesDisplayScreenEvent);
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
}
