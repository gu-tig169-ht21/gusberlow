import 'package:flutter/material.dart';
import './api.dart';

class ToDoItem {
  String? id;
  String? toDoText;
  bool isChanged;

  ToDoItem({this.id, this.toDoText, this.isChanged = false});

  void checkboxChanged(ToDoItem) {
    isChanged = !isChanged;
  }

  static Map<String, dynamic> toJson(ToDoItem task) {
    return {
      'title': task.toDoText,
      'id': task.id,
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
  late List<ToDoItem> _list = [];
  int _filterTo = 3;

  List<ToDoItem> get list => _list;

  int get filterTo => _filterTo;

  Future getList() async {
    List<ToDoItem> list = await Api.getTodos();
    _list = list;
    notifyListeners();
  }

  void setFilterTo(int filterTo) {
    _filterTo = filterTo;
    notifyListeners();
  }

  void addTask(ToDoItem task) async {
    _list = await Api.addTask(task);
    notifyListeners();
  }

  void removeTask(ToDoItem task) async {
    _list = await Api.deleteTask(task.id.toString());
    notifyListeners();
  }

  void isChanged(ToDoItem task) async {
    _list = await Api.changeTask(task.id.toString());
//    task.checkboxChanged(task);
    notifyListeners();
  }
}
