import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/src/CoronaDashboard/main.dart';
//import 'package:flutter_login/src/CoronaDashboard/main.dart';
import 'package:flutter_login/src/pages/MedecinPatients.dart';
import 'package:flutter_login/src/pages/SuivrePatient.dart';
import 'package:http/http.dart' as http;
import 'DetailRdv.dart';
import 'Calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login/src/pages/Forum/view/pages/home_page.dart';
import 'Forum/main.dart';

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
          Uri.encodeFull("http://192.168.1.65:4000/user/GetRdvMedecin"),
          headers: {
            "Accept": "application/json",
            "token" : "5e5aa4ad190d8c2818a66a08"
          }
      );

      this.setState(() {

        this.data = json.decode(response.body);
      });


      return "Success";
    }

//Get Patient Data
    Future<String> getPatientData(String idpatient) async {
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.65:4000/user/GetUserByID"),
          headers: {
            "Accept": "application/json",
            "token" : idpatient
          }
      );
      this.setState(() {


        this.Patients = json.decode(response.body);
      });


      return "Success";
    }
//Get Patient Data

    getData().then((data) async {
      for(int i=0 ; i<this.data.length;i++){
             if(this.data[i]['idpatient'] != null ){
               print("RAFIKEEE"+i.toString()+" "+this.data[i]['idpatient']);
               getPatientData(this.data?.elementAt(i)["idpatient"]).then((data) async {
                 for(int j=0 ; j<this.data.length;j++){
                   print(this.Patients?.elementAt(j)['email']);
                   Patientsitems.add(new Patient(this.Patients?.elementAt(j)['nom'],this.Patients?.elementAt(j)['prenom']));
                 }
               });
               items.add(new RendezVous("assets/images/patient.png", this.data?.elementAt(i)["idpatient"], this.data?.elementAt(i)["idmedecin"],this.data?.elementAt(i)["_id"]));

             }else{
               Patientsitems.add(new Patient("rokhs","darkhle3a"));
               items.add(new RendezVous("assets/images/patient.png", "field", "sds","sdfsds"));

             }
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailRendezVousMedecin(data?.elementAt(index)["_id"])));
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
                      child: Image.asset(items?.elementAt(index).img),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      Patientsitems[index].nom+' '+Patientsitems?.elementAt(index).prenom,
                      style:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.blueGrey),
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
        body: Center(
          child: Stack(
            children: <Widget>[
                  ListView.builder(
                itemCount: Patientsitems.length,
                itemBuilder: (context, index) => MedcCell(context, index),
              )
            
            ],
          ),
        )
    );


  }

}
