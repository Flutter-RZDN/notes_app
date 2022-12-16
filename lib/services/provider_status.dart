import 'package:flutter/cupertino.dart';
import 'package:notes_app/model/notes_class.dart';
import 'package:notes_app/services/notes_service.dart';

class StatusProvider with ChangeNotifier {
  bool _isSelected = false;
  List<NotesClass> _notes = [];
  List<NotesClass> _deleteNotes = [];

  bool get isSelected => _isSelected;
  List<NotesClass> get notes => _notes;
  List<NotesClass> get deleteNotes => _deleteNotes;

  Future<void> setIsSelected() async {
    _isSelected = !_isSelected;
    notifyListeners();
  }

  Future<void> getNotes() async {
    _notes = await NotesService.getAllNotes();

    notifyListeners();
  }

  Future<void> setDeleteNote(NotesClass notesClass) async {
    _deleteNotes.add(notesClass);
    notifyListeners();
  }

  bool validIsSelected(int id) {
    final data = _deleteNotes.where((element) => element.id == id);
    if (data.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> removeOfListDeleteNote(int id) async {
    _deleteNotes.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> deleteAllNotes() async {
    for (int i = 0; i < _deleteNotes.length; i++) {
      await NotesService.deleteNote(_deleteNotes[i].id);
    }
    _deleteNotes = [];
    notifyListeners();
  }

  Future<void> removeAllNotesOfListDeleteNotes() async {
    _deleteNotes = [];
    notifyListeners();
  }
}
