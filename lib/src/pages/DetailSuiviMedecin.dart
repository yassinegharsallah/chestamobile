import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/models/User.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailSuiviMedecins extends StatefulWidget {
  String idpatient ;
  DetailSuiviMedecins(String token) {
    this.idpatient = token ;
  }


  @override
  _DetailSuiviMedecinsState createState() => _DetailSuiviMedecinsState(this.idpatient);
}

class Medecin {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  Medecin(this.img, this.title, this.body,this.idMedecin);
}

class _DetailSuiviMedecinsState extends State<DetailSuiviMedecins> {
  List<Medecin> items = new List<Medecin>();
  List data;


  _DetailSuiviMedecinsState(token) {
    /* Fetching Data Into ListView */
  print("ID PATIENT "+token);
    Future<String> getData() async {
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetSuiviByidPatient"),
          headers: {
            "Accept": "application/json",
            "token" : '5e57b3d05acb9c4da455bbc2'
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
        print(this.data[i]["email"]);
        print(i);
        items.add(new Medecin("assets/images/document.png", this.data[i]["objet"], this.data[i]["details"],this.data[i]["_id"]));
      }
    });


    /* Fetching Data Into ListView */
  }

  Widget MedcCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final username = prefs.getString('username');
        final email = prefs.getString('email');
        final idLoggedInuser = prefs.getString('idLoggedinUser');
        final snackBar = SnackBar(content: Text("Tap"));
      /*  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(items[index]))); */
      },
      child: Card(
          margin: EdgeInsets.all(8),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      items[index].title,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suivi Patient"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => MedcCell(context, index),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
