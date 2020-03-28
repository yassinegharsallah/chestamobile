import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListeMedecins.dart';
import 'package:http/http.dart' as http;

import 'Reminder/full_page_analog_time_picker.dart';
import 'TodoTask.dart';

class MyDetailPage extends StatefulWidget {
  Medecin _Medc;
  String idpatient  ;

  MyDetailPage(Medecin Medc) {
    _Medc = Medc;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_Medc);
}

class _MyDetailPageState extends State<MyDetailPage> {
  Medecin Medc;

  _MyDetailPageState(Medecin Medc) {
    this.Medc = Medc;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(Medc.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: Medc,
            child: Transform.scale(
              scale: 2.0,
              child: Image.asset(Medc.img),
            ),
          ),
          Card(
            elevation: 8,
            margin: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(Medc.body),
            ),
          ),
          IconButton(
              icon: Icon(Icons.rate_review),
              color: Colors.blueAccent,
              onPressed: () async {
                // LOGIN GET REQUEST IS HERE
                var url ='http://192.168.1.12:4000/user/AddRdv';
                final prefs = await SharedPreferences.getInstance();
                var body = jsonEncode({
                  'idpatient' : prefs.getString('idLoggedinUser'),
                  'idmedecin' : this.Medc.idMedecin  });

                print("Body: " + body);

                http.post(url,
                    headers: {"Content-Type": "application/json"},
                    body: body
                ).then((http.Response response) async {
                  print("Response status: ${response.statusCode}");
                  print("Response body: ${response.body}");
                  print(response.headers);
                  print(response.request);
                  //JSON DECODEER

                });
                // LOGIN GET REQUEST IS HERE

      }),

        RaisedButton.icon(
          onPressed: () =>   Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ToDoListApp())),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text('Suivi Hebdomodaire',
            style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.calendar_today, color:Colors.white,),
          textColor: Colors.white,
          splashColor: Colors.red,
          color: Colors.lightBlue,)
          ,
          RaisedButton.icon(
            onPressed: () =>   Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullPageAnalogTimePicker())),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('Set Reminder',
              style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.timer, color:Colors.white,),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.lightBlue,)
        ],
      )),
    );
  }
}
