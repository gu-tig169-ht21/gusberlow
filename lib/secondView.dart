import 'package:flutter/material.dart';
import './model.dart';

class SecondView extends StatefulWidget {
  final ToDoItem task;

  SecondView(this.task);

  @override
  State<StatefulWidget> createState() {
    return SecondViewState(task);
  }
}

class SecondViewState extends State<SecondView> {
  String? toDoText;

  late TextEditingController textEditingController;

  SecondViewState(ToDoItem task) {
    this.toDoText = task.toDoText;

    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        toDoText = textEditingController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TIG169 TODO')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20),
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?'),
            ),
            //          TaskInputField(ToDoItem(toDoText: this.toDoText)),
            Container(height: 20),
            AddTask(),
          ],
        ),
      ),
    );
  }

  Widget AddTask() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          label: Text('Add'),
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pop(context, ToDoItem(toDoText: toDoText));
          },
        ),
      ],
    );
  }
}

class TaskInputField extends StatelessWidget {
  final ToDoItem task;

  TaskInputField(this.task);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'What are you going to do?'),
      ),
    );
  }
}
