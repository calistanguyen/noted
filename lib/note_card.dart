// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NoteCard extends StatefulWidget {
  const NoteCard(
      {Key? key,
      required this.text,
      required this.date,
      required this.isFavored,
      required this.itemIndex,
      required this.removeItem,
      required this.favoredListener})
      : super(key: key);
  final String text;
  final String date;
  final bool isFavored;
  final int itemIndex;
  final Function(int) removeItem;
  final Function(int, bool) favoredListener;
  // final List<note.Note> noteList;
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
                    index: widget.itemIndex,
                    removeItem: widget.removeItem,
                    isFavored: widget.isFavored,
                    favoredListener: widget.favoredListener,
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
  const BottomRow({
    Key? key,
    required this.date,
    required this.index,
    required this.isFavored,
    required this.removeItem,
    required this.favoredListener,
  }) : super(key: key);

  final String date;
  final int index;
  final bool isFavored;
  final Function(int) removeItem;
  final Function(int, bool) favoredListener;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(date),
            Row(
              children: [
                HeartIcon(
                  isFavored: isFavored,
                  favoredListener: favoredListener,
                  index: index,
                ),
                DeleteIcon(
                  index: index,
                  removeItem: removeItem,
                ),
              ],
            )
          ],
        ));
  }
}

class DeleteIcon extends StatelessWidget {
  const DeleteIcon({Key? key, required this.index, required this.removeItem})
      : super(key: key);

  final int index;
  final Function(int) removeItem;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => removeItem(index),
      icon: Icon(Icons.delete_outline),
      padding: EdgeInsets.all(0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}

class HeartIcon extends StatelessWidget {
  const HeartIcon(
      {Key? key,
      required this.isFavored,
      required this.favoredListener,
      required this.index})
      : super(key: key);
  final bool isFavored;
  final int index;
  final Function(int, bool) favoredListener;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (isFavored
          ? const Icon(Icons.favorite)
          : const Icon(Icons.favorite_outline)),
      color: (isFavored
          ? Theme.of(context).colorScheme.primaryVariant
          : Colors.black),
      padding: EdgeInsets.all(0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () => {favoredListener(index, !isFavored)},
    );
  }
}

// class _HeartIconState extends State<HeartIcon> {
//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: (widget.isFavored
//           ? const Icon(Icons.favorite)
//           : const Icon(Icons.favorite_outline)),
//       color: (widget.isFavored
//           ? Theme.of(context).colorScheme.primaryVariant
//           : Colors.black),
//       padding: EdgeInsets.all(0),
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onPressed: () =>
//           {widget.favoredListener(widget.index, !widget.isFavored)},
//     );
//   }
// }
