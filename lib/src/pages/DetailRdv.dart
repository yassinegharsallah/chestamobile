import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(DetailPage());
class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Post.fromJson(json.decode(response.body));
  });
}
class DetailPage extends StatelessWidget {

  final Future<Post> post;

  DetailPage({Key key, this.post}) : super(key: key);
  static final CREATE_POST_URL = 'https://jsonplaceholder.typicode.com/posts';
  TextEditingController textControler = new TextEditingController();
  TextEditingController phoneControler = new TextEditingController();
  TextEditingController dateControler = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Form Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}
// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Reminder Text',
              labelText: 'Text',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter a phone number',
              labelText: 'Phone',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter date and time',
              labelText: 'Enter date and time',
            ),
          ),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new RaisedButton(
                child: const Text('Set Reminder'),
                color: Colors.lightBlue,
                onPressed:  () async {
                  Post newPost = new Post(
                      userId: "123", id: 0, title: '', body: '');
                  Post p = await createPost("http://10.0.2.2:3000/addReminder/newreminder/test/test",
                      body: newPost.toMap());
                  print(p.title);
                },
              )),
          new Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: new RaisedButton(
                child: const Text('Delete'),
                color: Colors.lightBlue,
                onPressed:  () async {
                  Post newPost = new Post(
                      userId: "123", id: 0, title: '', body: '');
                  Post p = await createPost("http://10.0.2.2:3000/addReminder/newreminder/test/test",
                      body: newPost.toMap());
                  print(p.title);
                },
              ))
    ,
        ],
      ),
    );
  }
}