import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Everything the user adds to the list is a task.
//Task provider is self explanatory and its job is being the provider for the project.

class Task {
  final String id;
  String description;
  DateTime dueDate;
  TimeOfDay dueTime;
  bool isDone;

  Task({
    @required this.id,
    @required this.description,
    this.dueDate,
    this.dueTime,
    this.isDone = false,
  });
}

class TaskProvider with ChangeNotifier {
  List data;
  List<Task> get itemsList {
    print('GET  DATA GET ');
    getData().then((data){
      for(int i=0 ; i<this.data.length;i++){
        print(this.data[i]["_id"]);
        print(i);
        _toDoList.add(new Task( id: this.data[i]["_id"],
          description: this.data[i]["description"],
          dueDate:  DateTime.now(),
          dueTime: TimeOfDay.now(),));
      }
    });
    return _toDoList;
  }

  /* Fetching Data Into ListView */

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.12:4000/user/GetSuivi"),
        headers: {
          "Accept": "application/json"
        }
    );


      this.data = json.decode(response.body);
      print(response.body);

    return "Success";
  }

  /* Fetching Data Into ListView */

  final List<Task> _toDoList = [

  ];

  Task getById(String id) {
    return _toDoList.firstWhere((task) => task.id == id);
  }

  void createNewTask(Task task) {
    final newTask = Task(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _toDoList.add(newTask);
    notifyListeners();
  }

  void editTask(Task task) {
    removeTask(task.id);
    createNewTask(task);
  }

  void removeTask(String id) {
    _toDoList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void changeStatus(String id) {
    int index = _toDoList.indexWhere((task) => task.id == id);
    _toDoList[index].isDone = !_toDoList[index].isDone;
    //print('PROVIDER ${_toDoList[index].isDone.toString()}');
  }
}
