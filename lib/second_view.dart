import 'package:flutter/material.dart';
import './model.dart';

//andra sidan, där en ny task läggs till

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
  //scaffolden för denna view, med appbar samt textfield där ny task skrivs in, och addTask som skapas längre ner
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
                  border: OutlineInputBorder(), hintText: 'Add new todo-task'),
            ),
            Container(height: 20),
            addTask(),
          ],
        ),
      ),
    );
  }

//add-knappen under textfältet som när den blir klickad på sparar en inskriven task och lägger till i listan på första sidan
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
