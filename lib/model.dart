import 'package:flutter/material.dart';
import 'package:markbook/services/DatabaseHandler.dart';

class Between {
  ListOfToDoLists list= Consumer<ListOfToDoLists>.g
}

class ListOfToDoLists extends ChangeNotifier {
  List<ToDoListModel> _list = [];
DatabaseHandler _handler = DatabaseHandler();
  List<ToDoListModel> get getList => _list;



  void addData(ToDoListModel newToDoList) {
    _list.add(newToDoList);
    notifyListeners();
  }

  void addList() {
    _list.add(ToDoListModel());
    notifyListeners();
  }

  void removeData(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  void insertData(int index, ToDoListModel newToDoList) {
    _list.insert(index, newToDoList);
    notifyListeners();
  }
}

class ToDoListModel {
  List<MarkModel> _data = [];

  //MarkModel _newMark;

  List<MarkModel> get getData => _data;

  void newData(List<MarkModel> _newToDoList) {
    _data =_newToDoList;
  }

  void addData(MarkModel newMark) {
    _data.add(newMark);
  }

  void addMark() {
    _data.add(MarkModel());
  }

  void removeData(int index) {
    _data.removeAt(index);
  }

  void insertData(int oldIndex, int newIndex) {
    MarkModel _tempMark = MarkModel();
    _tempMark = _data[oldIndex];
    _data.removeAt(oldIndex);
    _data.insert(newIndex, _tempMark);
  }
}

class MarkModel {
  String _note = '';

  String get getNote => _note;
  bool _done = false;

  bool get getDone => _done;
  bool _priority = false;

  bool get getPriority => _priority;

  void changeNote(String newNote,) {
    _note = newNote;
  }

  void changeDone() {
    _done = !_done;
  }

  void changeDoneArg(bool _argD) {
    _done = _argD;
  }

  void changePriority() {
    _priority = !_priority;
  }

  void changePriorityArg(bool _argP) {
    _priority = _argP;
  }

  MarkMapModel toMarkMapModel() {
    MarkMapModel mmm = MarkMapModel(
        note: _note, done: _done ? 1 : 0, priority: _priority ? 1 : 0);
    return mmm;
  }

  MarkModel fromMarkMapModel(MarkMapModel _mmm) {
    MarkModel mark = MarkModel();
    mark.changeNote(_mmm.note);
    if (_mmm.done == 1) {
      mark.changeDoneArg(true);
    } else {
      mark.changeDoneArg(false);
    };
    if (_mmm.priority == 1) {
      mark.changePriorityArg(true);
    } else {
      mark.changePriorityArg(false);
    };
    return mark;
  }

// MarkModel.fromMap(Map<String, dynamic> res)
//     : _note = res['note'],
//       _done = res['done'],
//       _priority = res['priority'];
//
// Map<String, Object?> toMap() {
//   return {'note': _note, 'done': _done, 'priority': _priority};
// }
}

class ToDoListMapModel {
  List<MarkMapModel> data = [];

  ToDoListMapModel.fromMap(Map<String, dynamic> res) : data = res['data'];

  Map<String, Object?> toMap() {
    return {'data': data};
  }
}

class MarkMapModel {
  final int? id;
  final String note;
  final int done;
  final int priority;

  MarkMapModel({ this.id,
    required this.note,
    required this.done,
    required this.priority});

  MarkMapModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        note = res['note'],
        done = res['done'],
        priority = res['priority'];

  Map<String, Object?> toMap() {
    return {'id': id, 'note': note, 'done': done, 'priority': priority};
  }
}
