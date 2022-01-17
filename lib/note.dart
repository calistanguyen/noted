class Note {
  String text;
  String date;
  bool isFavored;
  String id;

  Note({
    required this.text,
    required this.date,
    required this.id,
    this.isFavored = false,
  });

  void setText(String t) {
    text = t;
  }

  void setIsFavored(bool favored) {
    isFavored = favored ? true : false;
  }

  void setDate(String d) {
    date = d;
  }
}
