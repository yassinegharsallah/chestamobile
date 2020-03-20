import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/models/User.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RendezVousMedecin extends StatefulWidget {
  RendezVousMedecin({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _RendezVousMedecinState createState() => _RendezVousMedecinState();
}

class RendezVous {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  RendezVous(this.img, this.title, this.body,this.idMedecin);
}

class _RendezVousMedecinState extends State<RendezVousMedecin> {
  List<RendezVous> items = new List<RendezVous>();
  List data;



  _RendezVousMedecinState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvMedecin"),
          headers: {
            "Accept": "application/json",
            "token" : "555555555"
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
      //  print(this.data[i]["email"]);
     //   print(i);
        items.add(new RendezVous("assets/images/hulk.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["_id"]));
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
        print('**************************** USER INFO *******************************************');
        print(username);
        print(email) ;
        print("id Logged in user : "+idLoggedInuser) ;
        final snackBar = SnackBar(content: Text("Tap"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()));
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
        title: Text(widget.title),
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
