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

//hämtar listan med de todos som finns sparade från Api
  Future getList() async {
    List<ToDoItem> list = await Api.getTodos();
    _list = list;
    notifyListeners();
  }

//sätter filtret till det värde som är valt utav "All"/"Done"/"Undone"
  void setFilterTo(int filterTo) {
    this._filterTo = filterTo;
    notifyListeners();
  }

//lägger till task både lokalt och för api
  void addTask(ToDoItem task) async {
    _list = await Api.addTask(task);
    notifyListeners();
  }

//tar bort task både lokalt och för api
  void removeTask(ToDoItem task) async {
    _list = await Api.deleteTask(task.id);
    notifyListeners();
  }

//ändrar status för task beroende på om checkbox har klickats i eller ej
  void changingTask(ToDoItem task) async {
    task.checkboxChanged(task);
    _list = await Api.changeTask(task.id, task);
    notifyListeners();
  }

//ändrar status till "done" när en checkbox klickats i
  void isDone(ToDoItem task) async {
    task.checkboxChanged(task);
    notifyListeners();
  }
}
