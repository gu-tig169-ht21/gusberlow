import 'package:flutter/material.dart';
import './api.dart';

class ToDoItem {
  String id;
  String toDoText;
  bool isChanged;

  ToDoItem({required this.id, required this.toDoText, this.isChanged = false});

  void checkboxChanged(ToDoItem task) {
    isChanged = !isChanged;
  }

  static Map<String, dynamic> toJson(ToDoItem task) {
    return {
      'title': task.toDoText,
      'done': task.isChanged,
    };
  }

  static ToDoItem fromJson(Map<String, dynamic> json) {
    return ToDoItem(
      id: json['id'],
      toDoText: json['title'],
      isChanged: json['done'],
    );
  }
}

class MyState extends ChangeNotifier {
  List<ToDoItem> _list = [];
  int _filterTo = 0;

  List<ToDoItem> get list => _list;
  int get filterTo => _filterTo;

  Future getList() async {
    List<ToDoItem> list = await Api.getTodos();
    _list = list;
    notifyListeners();
  }

  void setFilterTo(int filterTo) {
    this._filterTo = filterTo;
    notifyListeners();
  }

  void addTask(ToDoItem task) async {
    _list = await Api.addTask(task);
    notifyListeners();
  }

  void removeTask(ToDoItem task) async {
    _list = await Api.deleteTask(task.id);
    notifyListeners();
  }

  void changingTask(ToDoItem task) async {
    task.checkboxChanged(task);
    _list = await Api.changeTask(task.id, task);
//    task.checkboxChanged(task);
    notifyListeners();
  }

  void isDone(ToDoItem task) async {
    task.checkboxChanged(task);
    notifyListeners();
  }
}
