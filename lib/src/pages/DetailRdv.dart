import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/models/User.dart';
import 'Calendar.dart';
import 'DetailRdv.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailRendezVousMedecin extends StatefulWidget {

  DetailRendezVousMedecin(idRendezVous){
    print('HERE');
    setData(idRendezVous) ;
  }

  setData(data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('idRendezVous',data) ;
    print('KHANCHOURRR');
    print('KHANCHOURR'+prefs.getString('idRendezVous'));
  }
  @override
  _DetailRendezVousMedecinState createState() => _DetailRendezVousMedecinState();
}

class RendezVous {
  String idRdv ;
  String idpatient ;
  String idMedecin ;
  String Date ;
  String heure ;
  RendezVous(this.idMedecin, this.idpatient);
}

class _DetailRendezVousMedecinState extends State<DetailRendezVousMedecin> {
  List data;
  RendezVous RequestedRdv  = new RendezVous('', '');

  _DetailRendezVousMedecinState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
      final prefs = await SharedPreferences.getInstance();
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvByID"),
          headers: {
            "Accept": "application/json",
            "token" : prefs.get('idRendezVous')
          }
      );

      this.setState(() {

        this.data = json.decode(response.body);
      });


      return "Success";
    }

    // await getData()  ;  // <--- your code needs to pause until the Future returns.

    print('GET  DATA GET FROM DETAIL PAGE YE BRO ');

    getData().then((data) async {
        this.RequestedRdv.idMedecin = this.data[0]["idmedecin"];
        this.RequestedRdv.idpatient = this.data[0]["idpatient"];
        this.RequestedRdv.idpatient = this.data[0]["idpatient"];
        this.RequestedRdv.idpatient = this.data[0]["idpatient"];

        final prefs = await SharedPreferences.getInstance();
        this.RequestedRdv.idRdv = prefs.get('idRendezVous') ;
        print('id rdv '); print(this.RequestedRdv.idRdv);
    });


    /* Fetching Data Into ListView */
  }



  @override
  Widget build(BuildContext context) {
    final title = 'Rendez Vous';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),

        body: ListView(
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.access_time),
                title: Text(this.RequestedRdv.idMedecin)
                ,
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text(this.RequestedRdv.idpatient),
            ),
            RaisedButton(
                child: Text("Confirmer Rendez Vous"),
                color: Colors.blue,
                onPressed: () async =>   await http.put(
            Uri.encodeFull("http://192.168.1.12:4000/user/UpdateRdvByID"),
        headers: {
          "Accept": "application/json",
          "token": this.RequestedRdv.idRdv,
          "etat": "confirmer"
        }
    )
    ),            RaisedButton(
                child: Text("Annuler Rendez Vous"),
                color: Colors.blue,
                onPressed: () async =>   await http.delete(
    Uri.encodeFull("http://192.168.1.12:4000/user/DeleteRdvByID"),
        headers: {
          "Accept": "application/json",
          "token": this.RequestedRdv.idRdv,
        }
    )
                ),  RaisedButton(
                child: Text("Calendrier"),
                color: Colors.blue,
                onPressed: () async =>  Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Calendar(),
                )
            ))],

//TableCalendar
        ),

      ),

    );

  }
}
