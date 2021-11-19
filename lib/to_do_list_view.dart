import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'second_view.dart';
import 'to_do_list.dart';

class ToDoListView extends StatelessWidget {
  const ToDoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TIG169 TODO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => ToDoList(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SecondView(ToDoItem(toDoText: 'Något att göra'))));
          if (newTask != null) {
            //lägg till ny task
            Provider.of<MyState>(context, listen: false).addTask(newTask);
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 42),
      ),
    );
  }
}
