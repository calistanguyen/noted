// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:noted/note_card.dart';
import 'note.dart' as note;
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

var noteList = [];

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

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
                  fontSize: 64,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              headline2: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              headline3: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
              bodyText1: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              bodyText2: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  color: Colors.black)),
        ),
        // home: const MyHomePage(title: 'noted'),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('you have an error! ${snapshot.error.toString()}');
                return Text('Something went wrong!');
              } else if (snapshot.hasData) {
                return MyHomePage(title: 'noted');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _deleteListItem(int index) {
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref("notes/${noteList[index].id}");
    dbRef.set(null);
    setState(() {
      noteList.removeAt(index);
    });
  }

  void _setFavored(int index, bool currentFavored) {
    setState(() {
      noteList[index].setIsFavored(currentFavored);
    });
  }

  void _addNote(note.Note newNote) {
    setState(() {
      noteList.add(newNote);
    });
    DatabaseReference dbRef =
        FirebaseDatabase.instance.ref("notes/${newNote.id}");
    dbRef.set({
      "id": newNote.id,
      "date": newNote.date,
      "text": newNote.text,
      "isFavored": newNote.isFavored,
    });
  }

  //   DatabaseReference ref = FirebaseDatabase.instance.ref("notes");
  // ref.onValue.listen((event) {
  //   (event.snapshot.value as Map<dynamic, dynamic>).forEach((key, value) {
  //     noteList.add(note.Note(
  //         id: key,
  //         text: value['text'],
  //         isFavored: value['isFavored'],
  //         date: value['date']));
  //   });
  // });
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
                  text: noteList[index].text,
                  date: noteList[index].date,
                  isFavored: noteList[index].isFavored,
                  itemIndex: index,
                  removeItem: _deleteListItem,
                  favoredListener: _setFavored,
                );
              })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                    context: context,
                    builder: (BuildContext context) => AddNoteDialog())
                .then((value) => {_addNote(value)});
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context)
              .primaryColorDark), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String currentDate() {
  var now = DateTime.now();
  var formatter = DateFormat.yMd().add_jm();
  String formattedDate = formatter.format(now);
  return formattedDate;
}

customPopupBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(15));
}

Widget submitNoteButton(BuildContext context, note.Note newNote) {
  return ElevatedButton(
      onPressed: () => {Navigator.of(context).pop(newNote)},
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text("submit", style: Theme.of(context).textTheme.headline3),
      ),
      style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.only(left: 65, right: 65)));
}

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({Key? key}) : super(key: key);

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final TextEditingController noteController = TextEditingController();

  var text = "";

  @override
  void initState() {
    super.initState();
    noteController.addListener(() {
      setState(() {
        text = noteController.text;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var uuid = Uuid();
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
            side: BorderSide(color: Colors.black, width: 2)),
        insetPadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        content: SizedBox(
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
                      maxLength: 50,
                      cursorColor: Colors.black,
                      controller: noteController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        hoverColor: Colors.black,
                        focusedBorder: customPopupBorder(),
                        enabledBorder: customPopupBorder(),
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
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: submitNoteButton(context,
                    note.Note(text: text, date: currentDate(), id: uuid.v4())),
              )
            ],
          ),
        ));
  }
}
