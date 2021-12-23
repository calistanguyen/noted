// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:noted/note_card.dart';
import 'note.dart' as note;

void main() {
  runApp(const MyApp());
}

var test = note.Note(text: "global variable", date: "12/23/21");

var noteList = [
  note.Note(text: "global variable", date: "12/23/21"),
  note.Note(text: "global variable", date: "12/23/21"),
  note.Note(text: "global variable", date: "12/23/21"),
  note.Note(text: "global variable", date: "12/23/21"),
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(248, 187, 208, 1),
        primaryColorLight: Color.fromRGBO(255, 238, 255, 1),
        primaryColorDark: Color.fromRGBO(196, 139, 159, 1),
        scaffoldBackgroundColor: Color.fromRGBO(255, 238, 255, 1),
        fontFamily: 'Dongle',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 64, fontWeight: FontWeight.w700, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ),
      home: const MyHomePage(title: 'noted'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addToList() {
    setState(() {
      noteList.add(note.Note(text: "this is a new note", date: "12/23/21"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline1),
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Color.fromARGB(0, 0, 0, 0),
        centerTitle: false,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteCard(
                    text: noteList[index].text, date: noteList[index].date);
              })),
      floatingActionButton: FloatingActionButton(
          onPressed: _addToList,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context)
              .primaryColorDark), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
