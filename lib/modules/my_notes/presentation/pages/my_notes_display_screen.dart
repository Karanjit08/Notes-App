import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class MyNotesDisplayScreen extends StatefulWidget {
  const MyNotesDisplayScreen({super.key});

  @override
  State<MyNotesDisplayScreen> createState() => _MyNotesDisplayScreenState();
}

class _MyNotesDisplayScreenState extends State<MyNotesDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {  },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: HexColor('#F8EEE2'),
      ),
    );
  }
}
