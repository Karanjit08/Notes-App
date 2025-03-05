import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/core/config/themes/themes.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/pages/my_notes_landing_screen.dart';
import 'package:flutter_note_app/modules/my_notes/presentation/state_management/notes_bloc.dart';


void main() {
  runApp(flutterApp());
}

class flutterApp extends StatefulWidget {
  const flutterApp({super.key});

  @override
  State<flutterApp> createState() => _flutterAppState();
}

class _flutterAppState extends State<flutterApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NotesBloc>(
            create: (BuildContext context) =>  NotesBloc(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyNotesLandingScreen(),
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: ThemeMode.system,
        )
    );
  }
}
