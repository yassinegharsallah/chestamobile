import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/providers/task.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'list_item.dart';

class TasksList extends StatefulWidget {
  TasksList({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _TasksListState createState() => _TasksListState();
}



class _TasksListState extends State<TasksList> {
  List<Task> items = new List<Task>();
  List data;



  _TasksListState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.7:4000/user/GetSuivi"),
          headers: {
            "Accept": "application/json"
          }
      );

      this.setState(() {

        this.data = json.decode(response.body);
      });


      return "Success";
    }

    // await getData()  ;  // <--- your code needs to pause until the Future returns.
    print('GET  DATA GET ');
    getData().then((data){
      for(int i=0 ; i<this.data.length;i++){
        // print(this.data[i]["email"]);
        print(i);
        items.add(new Task(      id: 'task#1',
            description: this.data[i]["details"],
            dueDate: DateTime.now(),
            dueTime: TimeOfDay.now()));
      }
    });


    /* Fetching Data Into ListView */
  }

  @override
  Widget build(BuildContext context) {
    //   final taskList = Provider.of<TaskProvider>(context).itemsList;
    return  this.items.length > 0
        ? ListView.builder(
      itemCount: this.items.length,
      itemBuilder: (context, index) {
        return ListItem(this.items[index]);
      },
    )
        : LayoutBuilder(
      builder: (ctx, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.5,
                child: Image.asset('assets/images/waiting.png',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'No tasks added yet...',
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
        );
      },
    );
  }

}