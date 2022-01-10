import 'package:flutter/material.dart';
class X extends ChangeNotifier{
  int _x=0;
  int get getX=>_x;
  void inputX (int x){
    _x=x;
    notifyListeners();
  }
}
class Y extends ChangeNotifier{
  int _y=0;
  int get getY=>_y;
  void setY (int y){
    _y=y;
    notifyListeners();
  }
}

class ListOfToDoLists extends ChangeNotifier {
  List<ToDoListModel> _list = [];


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

class ToDoListModel  {
  List<MarkModel> _data = [];
  //MarkModel _newMark;

  List<MarkModel> get getData => _data;

  void addData(MarkModel newMark) {
    _data.add(newMark);

  }
  void addMark() {
    _data.add(MarkModel());

  }

  void removeData(int index) {
    _data.removeAt(index);

  }
  void insertData (int oldIndex, int newIndex){
    MarkModel _tempMark= MarkModel();
    _tempMark=_data[oldIndex];
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

  void changeNote(
    String newNote,
  ) {
    _note = newNote;

  }

  void changeDone() {
    _done = !_done;

  }

  void changePriority() {
    _priority = !_priority;

  }
}
