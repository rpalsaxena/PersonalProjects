import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _notes = prefs.getStringList('ff_notes') ?? _notes;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<String> _notes = [];
  List<String> get notes => _notes;
  set notes(List<String> _value) {
    _notes = _value;
    prefs.setStringList('ff_notes', _value);
  }

  void addToNotes(String _value) {
    _notes.add(_value);
    prefs.setStringList('ff_notes', _notes);
  }

  void removeFromNotes(String _value) {
    _notes.remove(_value);
    prefs.setStringList('ff_notes', _notes);
  }

  void removeAtIndexFromNotes(int _index) {
    _notes.removeAt(_index);
    prefs.setStringList('ff_notes', _notes);
  }

  void updateNotesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _notes[_index] = updateFn(_notes[_index]);
    prefs.setStringList('ff_notes', _notes);
  }

  void insertAtIndexInNotes(int _index, String _value) {
    _notes.insert(_index, _value);
    prefs.setStringList('ff_notes', _notes);
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
