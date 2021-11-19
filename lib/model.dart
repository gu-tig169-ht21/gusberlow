import 'package:flutter/material.dart';

class ToDoItem {
  String? toDoText;
  bool isChanged;

  ToDoItem({this.toDoText, this.isChanged = false});

  void checkboxChanged(ToDoItem) {
    isChanged = !isChanged;
  }
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list = [];
  int _filterTo = 3;

  List<ToDoItem> get list => _list;

  int get filterTo => _filterTo;

  void setFilterTo(int filterTo) {
    _filterTo = filterTo;
    notifyListeners();
  }

  void addTask(ToDoItem task) {
    _list.add(task);
    notifyListeners();
  }

  void removeTask(ToDoItem task) {
    _list.remove(task);
    notifyListeners();
  }

  void isChanged(ToDoItem task) {
    task.checkboxChanged(task);
    notifyListeners();
  }
}
