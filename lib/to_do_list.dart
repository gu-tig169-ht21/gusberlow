import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class ToDoList extends StatelessWidget {
  final List<ToDoItem> list;

  ToDoList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((task) => _listItem(context, task)).toList());
  }

  Widget _listItem(context, ToDoItem task) {
    var state = Provider.of<MyState>(context, listen: false);
    return CheckboxListTile(
      title: Text(task.toDoText),
      secondary: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          state.removeTask(task);
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: task.isChanged,
      onChanged: (value) {
        state.changingTask(task);
      },
    );
  }
}
