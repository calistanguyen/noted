// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({Key? key, required this.text, required this.date})
      : super(key: key);
  final String text;
  final String date;
  @override
  _NoteCardState createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 80,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.black, width: 1)),
          // alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              children: [
                Note(noteText: widget.text),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: BottomRow(
                    date: widget.date,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class Note extends StatelessWidget {
  const Note({Key? key, required this.noteText}) : super(key: key);

  final String noteText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(noteText, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}

class BottomRow extends StatelessWidget {
  const BottomRow({Key? key, required this.date}) : super(key: key);

  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(date), HeartIcon()],
        ));
  }
}

class HeartIcon extends StatefulWidget {
  const HeartIcon({Key? key}) : super(key: key);
  @override
  _HeartIconState createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  bool _isFavorited = false;

  void _favored() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (_isFavorited
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline)),
      color: (_isFavorited
          ? Theme.of(context).colorScheme.primaryVariant
          : Colors.black),
      padding: EdgeInsets.all(0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: _favored,
    );
  }
}
