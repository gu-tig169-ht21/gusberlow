import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'second_view.dart';
import 'to_do_list.dart';

//första sidan av appen, står som "home" till MaterialApp i main-filen
class ToDoListView extends StatelessWidget {
  const ToDoListView({Key? key}) : super(key: key);

//Uppbyggdnad av första sidan, appbar med en filterknapp, en body där ToDoList ligger (alltså listan med alla todos),
//samt en knapp för att lägga till ny todo som tar en till andra sidan av appen
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
                      SecondView(ToDoItem(toDoText: 'message', id: ''))));
          if (newTask != null) {
            //lägg till ny task i todo-listan
            Provider.of<MyState>(context, listen: false).addTask(newTask);
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 42),
      ),
    );
  }

//filterfunktionen, vad som ska visas på första sidan beroende på vilket val som gjorts under filterknappen
  List<ToDoItem> _filterList(list, value) {
    if (value == 1) return list;
    if (value == 2)
      return list.where((task) => task.isChanged == true).toList();
    else if (value == 3)
      return list.where((task) => task.isChanged == false).toList();
    return list;
  }
}
