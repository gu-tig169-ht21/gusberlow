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

  List<ToDoItem> get list => _list;

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

//state för checkboxen
class ToDoCB extends StatefulWidget {
  const ToDoCB({Key? key}) : super(key: key);

  @override
  State<ToDoCB> createState() => _ToDoCBState();
}

class _ToDoCBState extends State<ToDoCB> {
  bool? _myBool = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _myBool,
        onChanged: (value) {
          setState(() {
            _myBool = value;
          });
        });
  }
}
