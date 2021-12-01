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
  String toDoText = 'message';
  TextEditingController textEditingController = TextEditingController();

  SecondViewState(ToDoItem task) {
    this.toDoText = task.toDoText;

    textEditingController.addListener(() {
      setState(() {
        toDoText = textEditingController.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TIG169 TODO'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 20),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What are you going to do?'),
            ),
            Container(height: 20),
            addTask(),
          ],
        ),
      ),
    );
  }

  Widget addTask() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          label: const Text('Add'),
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pop(context, ToDoItem(toDoText: toDoText, id: ''));
          },
        ),
      ],
    );
  }
}

class TaskInputField extends StatelessWidget {
  final ToDoItem task;

  TaskInputField(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: const TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'What are you going to do?'),
      ),
    );
  }
}
