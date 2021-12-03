import 'dart:convert';
import 'package:http/http.dart' as http;
import './model.dart';

const API_KEY = 'bb6c8f70-9656-4e74-bef0-e511a998bc13';
const API_URL = 'https://todoapp-api-pyq5q.ondigitalocean.app';

class Api {
  //lägger till task till Api
  static Future<List<ToDoItem>> addTask(ToDoItem task) async {
    Map<String, dynamic> json = ToDoItem.toJson(task);
    var bodyString = jsonEncode(json);
    var response = await http.post(
      Uri.parse('$API_URL/todos?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

//tar bort task från Api
  static Future deleteTask(String taskId) async {
    var response =
        await http.delete(Uri.parse('$API_URL/todos/$taskId?key=$API_KEY'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

//ändrar(uppdaterar) en task i Api beroende på om checkbox är ifylld eller ej
  static Future changeTask(String taskId, ToDoItem task) async {
    Map<String, dynamic> json = ToDoItem.toJson(task);
    var bodyString = jsonEncode(json);
    var response = await http.put(
      Uri.parse('$API_URL/todos/$taskId?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }

//hämtar listan med sparade tasks/todos från Api
  static Future<List<ToDoItem>> getTodos() async {
    http.Response response =
        await http.get(Uri.parse('$API_URL/todos?key=$API_KEY'));
    var bodyString = response.body;
    var json = jsonDecode(bodyString);

    return json.map<ToDoItem>((data) {
      return ToDoItem.fromJson(data);
    }).toList();
  }
}
