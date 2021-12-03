import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

//Todo-listan som visas på första sidan av appen
class ToDoList extends StatelessWidget {
  final List<ToDoItem> list;

  ToDoList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((task) => _listItem(context, task)).toList());
  }

//hur varje task i todo-listan ska se ut, titeln är toDoText, längst till vänster
//finns ett kryss för att ta bort en task, och längst till höger en checkbox som
//kan få olika värde beroende på om den är icheckad eller ej
  Widget _listItem(context, ToDoItem task) {
    var state = Provider.of<MyState>(context, listen: false);
    return CheckboxListTile(
      title: Text(
        task.toDoText,
        style: TextStyle(
            decoration: task.isChanged ? TextDecoration.lineThrough : null),
      ),
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
