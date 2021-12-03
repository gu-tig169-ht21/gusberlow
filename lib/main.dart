import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'to_do_list_view.dart';
import 'package:http/http.dart' as http;

void main() async {
  var state = MyState();
  await state.getList(); //hämtar listan med sparade todos när appen startar

  runApp(
    ChangeNotifierProvider(
      create: (context) => state,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ToDoListView(),
    );
  }
}
