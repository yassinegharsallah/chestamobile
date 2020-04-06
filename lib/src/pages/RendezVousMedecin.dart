import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/src/CoronaDashboard/main.dart';
import 'package:flutter_login/src/pages/MedecinPatients.dart';
import 'package:flutter_login/src/pages/SuivrePatient.dart';
import 'package:http/http.dart' as http;
import 'DetailRdv.dart';
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
class Patient {
  final String nom;
  final String prenom;
  Patient(this.nom, this.prenom);
}
class _RendezVousMedecinState extends State<RendezVousMedecin> {
  List<RendezVous> items = new List<RendezVous>();
  List<Patient> Patientsitems = new List<Patient>();
  List data;
  List Patients ;




  _RendezVousMedecinState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
//      final prefs = await SharedPreferences.getInstance();
//Mtensech tzid id el logged in user mel prefs
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvMedecin"),
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

    print('GET  DATA GET ');
    getData().then((data) async {
      for(int i=0 ; i<this.data.length;i++){
      //  print(this.data[i]["email"]);
        print(i); print('nfetchi fel patient');
        getPatientData(this.data[i]["idpatient"]).then((data) async {
          for(int j=0 ; j<this.data.length;j++){
            print(this.Patients[j]['email']);
            Patientsitems.add(new Patient(this.Patients[j]['nom'],this.Patients[j]['prenom']));
            print('J VALUE :'); print(j);
          }
        });
        items.add(new RendezVous("assets/images/patient.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["_id"]));
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
        print('**************************** USER INFO *****************************');
        print(username);
        print(email) ;
        print("id Logged in user : "+idLoggedInuser) ;
        final snackBar = SnackBar(content: Text("Tap"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailRendezVousMedecin(data[index]["_id"])));
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
                color: Colors.deepPurple,
              ),
              child: Text(
                'CHESTA MOBILE',
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
