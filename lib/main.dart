import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'to_do_list_view.dart';

void main() {
  var state = MyState();

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ToDoListView(),
    );
  }
}
