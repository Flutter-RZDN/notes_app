class NotesClass {
  String _title = "";
  String _text = "";

  NotesClass(title, text) {
    _title = title;
    _text = text;
  }
  String get title => _title;
  String get text => _text;
}
