import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/models/User.dart';
import 'DetailRdv.dart';
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RendezVousPatient extends StatefulWidget {
  RendezVousPatient({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _RendezVousPatientState createState() => _RendezVousPatientState();
}

class RendezVous {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;
  final String etat ;
  final String idRendezVous ;
  RendezVous(this.img, this.title, this.body,this.idMedecin,this.etat,this.idRendezVous);
}
class Patient {
  final String nom;
  final String prenom;
  Patient(this.nom, this.prenom);
}
class _RendezVousPatientState extends State<RendezVousPatient> {
  List<RendezVous> items = new List<RendezVous>();
  List<Patient> Patientsitems = new List<Patient>();
  List data;
  List Patients ;


  _RendezVousPatientState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();
//Mtensech tzid id el logged in user mel prefs
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvPatient"),
          headers: {
            "Accept": "application/json",
            "token" :  prefs.getString('idLoggedinUser')
          }
      );

      this.setState(() {

        this.data = json.decode(response.body);
      });


      return "Success";
    }

//Get Patient Data
    Future<String> getPatientData(String idpatient) async {
//      final prefs = await SharedPreferences.getInstance();
//Mtensech tzid id el logged in user mel prefs
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetUserByID"),
          headers: {
            "Accept": "application/json",
            "token" : idpatient
          }
      );
      print('PATIENTS EXECUTION');
      this.setState(() {

        this.Patients = json.decode(response.body);
      });


      return "Success";
    }
//Get Patient Data

    print('GET  DATA GET ');
    getData().then((data) async {
      for(int i=0 ; i<this.data.length;i++){
        //  print(this.data[i]["email"]);
        print(i); print('nfetchi fel patient');
        getPatientData(this.data[i]["idmedecin"]).then((data) async {
          for(int j=0 ; j<this.data.length;j++){
            print(this.data[i]["idmedecin"]);
            Patientsitems.add(new Patient(this.Patients[j]['nom'],this.Patients[j]['prenom']));
            print('J VALUE :'); print(j);
          }
        });
        items.add(new RendezVous("assets/images/hulk.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["_id"],this.data[i]["etat"],this.data[i]["_id"]));
      }
    });



    /* Fetching Data Into ListView */
  }
  Future<void> _neverSatisfied(idRendezVous) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rendez-Vous'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez vous vraiment annuler ce rendez-vous ?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Annuler'),
              onPressed: () async {
               // Navigator.of(context).pop();
                print('here'+idRendezVous) ;
                await http.put(
                    Uri.encodeFull("http://192.168.1.12:4000/user/UpdateRdvByID"),
                    headers: {
                      "Accept": "application/json",
                      "token": idRendezVous,
                      "etat": "annuler"
                    }
                );
              },
            ),
            FlatButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
  Widget MedcCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () async {
         print('NEVER SATISFIED NEVER');  print(this.items[index].idRendezVous);
        _neverSatisfied(this.items[index].idRendezVous);

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

                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Dr '+Patientsitems[index].nom+' '+Patientsitems[index].prenom,
                      style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Icon(Icons.verified_user , color: this.items[index].etat =='confirmed'? Colors.green : Colors.redAccent),
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
