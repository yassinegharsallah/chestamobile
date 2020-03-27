library analog_time_picker;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'analog_time_picker.dart';
import 'utils.dart';

class FullPageAnalogTimePicker extends StatelessWidget {
  final Map mapData;
  final String route;
  final Widget container;

  FullPageAnalogTimePicker({Key key, this.mapData, this.container, this.route})
      : super(key: key);

  Map<String, DateTime> _dateTime = new Map();
  @override
  Widget build(BuildContext context) {
    print(mapData);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            container != null ? container : Container(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50.0),
              child: AnalogTimePicker(
                onChanged: getDayTime,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: Colors.deepPurpleAccent,
                child: Icon(Icons.add),
                onPressed:
                  //print(_dateTime);

          () async {
    // LOGIN GET REQUEST IS HERE
    var url ='http://192.168.1.12:4000/user/AddReminder';
    final prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format( _dateTime['date']);
    print('DATETIME CASSSSSSSSSSST'); print(formattedDate);
    var body = jsonEncode({
     'texte' : 'DEFAULT TEXT',
    'iduser' : prefs.getString('idLoggedinUser'),
    'date' :   formattedDate,
    'heure' : DateFormat.jm().format(_dateTime['time']).toString() });

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

    }

                ,
              ),
            ),
            MyBackButton(),
          ],
        ),
      ),
    );
  }

  void getDayTime(Map value) {
    _dateTime = value;
  }
}
