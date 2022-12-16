class NotesClass {
  final int? _id;
  final String? _createAt;
  final String? _updateAt;

  final String? _title;
  final String? _content;

  NotesClass(
      this._id, this._createAt, this._updateAt, this._title, this._content);

  String? get createAt => _createAt;
  String? get updateAt => _updateAt;
  int? get id => _id;
  String? get title => _title;
  String? get content => _content;

  Map<String, dynamic> toLocalDb() {
    return {
      "create_at": createAt,
      "update_at": updateAt,
      "title": title,
      "content": content,
    };
  }
}
