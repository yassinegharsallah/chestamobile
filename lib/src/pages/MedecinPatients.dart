import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MedecinPatients extends StatefulWidget {
  MedecinPatients({Key key}) : super(key: key);

  @override
  _MedecinPatientsState createState() => _MedecinPatientsState();
}

class _MedecinPatientsState extends State<MedecinPatients> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Acces Patient'),
        ),
        body: Center(
          child:FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedecinPatients() ));
            },
            child: Text(
              "Acces Patient",
              style: TextStyle(fontSize: 20.0),
            ),
          ),


      ),
    ));
  }
}
