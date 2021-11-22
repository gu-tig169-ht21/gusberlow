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
          PopupMenuButton(
              onSelected: (int value) {
                if (value != null)
                  Provider.of<MyState>(context, listen: false)
                      .setFilterTo(value);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(child: Text('All'), value: 1),
                    PopupMenuItem(child: Text('Done'), value: 2),
                    PopupMenuItem(child: Text('Undone'), value: 3),
                  ]),
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            ToDoList(_filterList(state.list, state.filterTo)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTask = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SecondView(ToDoItem(toDoText: 'A task to be done'))));
          if (newTask != null) {
            //lägg till ny task
            Provider.of<MyState>(context, listen: false).addTask(newTask);
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 42),
      ),
    );
  }

  List<ToDoItem> _filterList(list, value) {
    if (value == 2) return list.where((task) => task.doneTask == true).toList();
    if (value == 3)
      return list.where((task) => task.doneTask == false).toList();
    return list;
  }
}
