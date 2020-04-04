import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/src/CoronaDashboard/main.dart';
import 'package:flutter_login/src/pages/MedecinPatients.dart';
import 'package:flutter_login/src/pages/SuivrePatient.dart';
import 'package:http/http.dart' as http;
import 'DetailRdv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitationMedecinPatient extends StatefulWidget {
  InvitationMedecinPatient({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _InvitationMedecinPatientState createState() => _InvitationMedecinPatientState();
}

class Invitation {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  Invitation(this.img, this.title, this.body,this.idMedecin);
}
class Patient {
  final String nom;
  final String prenom;
  Patient(this.nom, this.prenom);
}
class _InvitationMedecinPatientState extends State<InvitationMedecinPatient> {
  List<Invitation> items = new List<Invitation>();
  List<Patient> Patientsitems = new List<Patient>();
  List data;
  List Patients ;




  _InvitationMedecinPatientState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
//      final prefs = await SharedPreferences.getInstance();
//Mtensech tzid id el logged in user mel prefs
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetInvitation"),
          headers: {
            "Accept": "application/json",
            "token" : "5e73d3e073761a37a036ce3a"
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

    getData().then((data) async {
      for(int i=0 ; i<this.data.length;i++){
        //  print(this.data[i]["email"]);
        print(i); print('nfetchi fel patient');
        getPatientData(this.data[i]["idpatient"]).then((data) async {
          for(int j=0 ; j<this.data.length;j++){
         //   print(this.Patients[j]['email']);
            Patientsitems.add(new Patient(this.Patients[j]['nom'],this.Patients[j]['prenom']));
            print('J VALUE :'); print(j);
          }
        });
        items.add(new Invitation("assets/images/doctor.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["_id"]));
      }
    });



    /* Fetching Data Into ListView */
  }

  //// DIALOG ////

  Future<void> _ackAlert(BuildContext context,idAccess) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () async {
                await http.put(
                    Uri.encodeFull("http://192.168.1.12:4000/user/AccepterInvitation"),
                    headers: {
                      "Accept": "application/json",
                      "token": idAccess,
                    }
                ) ;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //// DIALOG ////

  Widget MedcCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final username = prefs.getString('username');
        final email = prefs.getString('email');
        final idLoggedInuser = prefs.getString('idLoggedinUser');

        final snackBar = SnackBar(content: Text("Tap"));
          _ackAlert(ctx, items[index].idMedecin) ;
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
                      Patientsitems[index].nom+' '+Patientsitems[index].prenom,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.amber[800]),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CHESTA'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Detection Dashboard'),
                  onTap: ()=> {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoronaDashboard()))
                  }
              ),
              ListTile(
                leading: Icon(Icons.description),
                title: Text('Mes Rendez-vous'),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Calendrier'),
              ),
              ListTile(
                leading: Icon(Icons.forum),
                title: Text('Forum'),
              ),

              ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text('Mes Patients'),
                  onTap: ()=> {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedecinPatients()))
                  }),
            ],
          ),

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
        )
    );


  }

}
