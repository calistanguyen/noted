// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:noted/note_card.dart';
import 'note.dart' as note;
import 'package:intl/intl.dart';

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
            headline2: TextStyle(
                fontSize: 48, fontWeight: FontWeight.w700, color: Colors.black),
            headline3: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
            bodyText1: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black),
            bodyText2: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w100,
                color: Colors.black)),
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
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => AddNoteDialog());
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context)
              .primaryColorDark), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget customButton(BuildContext context) {
  return InkWell(
      onTap: () => {},
      child: Center(
          child: Container(
              width: 180,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).primaryColor),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("submit",
                      style: Theme.of(context).textTheme.headline3),
                ),
              ))));
}

String currentDate() {
  var now = DateTime.now();
  var formatter = DateFormat.yMd().add_jm();
  String formattedDate = formatter.format(now);
  return formattedDate; // 2016-01-25
}

class AddNoteDialog extends StatelessWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.black, width: 2)),
        // title: Text('new note', style: Theme.of(context).textTheme.headline2),
        child: SizedBox(
          height: 320,
          width: 333,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text('new note',
                    style: Theme.of(context).textTheme.headline2),
              ),
              SizedBox(
                  width: 270,
                  height: 100,
                  child: TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ))),
              Padding(
                padding: const EdgeInsets.only(left: 35.0, top: 5),
                child: Row(children: [
                  Icon(Icons.calendar_today_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 5),
                    child: Text(
                      currentDate(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Icon(Icons.favorite_outline),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: customButton(context),
              )
            ],
          ),
        ));
  }
}
