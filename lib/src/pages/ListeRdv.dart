import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/src/pages/DetailRdv.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
      home: new RdvList()
  ));
}

class RdvList extends StatefulWidget {
  @override
  RdvListState createState() => new RdvListState();
}

class RdvListState extends State<RdvList> {

  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvMedecin"),
        headers: {
          "Accept": "application/json",
          "token" : "5e5aa519190d8c2818a66a0a"
        }
    );

    this.setState(() {

      data = json.decode(response.body);
    });

    print(data[1]["idmedecin"]);

    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text("Listviews"), backgroundColor: Colors.blue),
      body: new ListView.builder(

        itemCount: data == null ? 0 : data.length,
               itemBuilder: (BuildContext context, int index){
               return  new GestureDetector(
                   onTap:  () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
                     builder: (context) => DetailPage(),
                   )),
                   child: new Card(
                       child: new Text(data[index]["idmedecin"]),
                       margin: const EdgeInsets.only(top: 50.0)
                   ),
                 );

        /*  return new Card(
            child: new Text(data[index]["idmedecin"]),
            margin: const EdgeInsets.only(top: 50.0),
            borderOnForeground: true,
          ); */
        },
      ),
    );
  }
}
