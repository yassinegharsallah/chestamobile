import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/src/CoronaDashboard/main.dart';
import 'package:flutter_login/src/pages/MedecinPatients.dart';
import 'package:http/http.dart' as http;
import 'DetailRdv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessPatient extends StatefulWidget {
  AccessPatient({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _AccessPatientState createState() => _AccessPatientState();
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
class _AccessPatientState extends State<AccessPatient> {
  List<RendezVous> items = new List<RendezVous>();
  List<Patient> Patientsitems = new List<Patient>();
  List Patients ;
  final myController = TextEditingController();




  _AccessPatientState() {
    /* Fetching Data Into ListView */


    /* Fetching Data Into ListView */
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inviter Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          Future<String> result =  SetPatientData();
          print('###########');
          String rs = 'dfdf';
          result.then((value) =>
              rs = value
          ) ;
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(rs),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.add_box),
      ),
    );
  }

   Future<String> SetPatientData () async {
     List data;
     String result ;
     var response = await http.get(
         Uri.encodeFull("http://192.168.1.12:4000/user/GetAllPatients"),
         headers: {
           "Accept": "application/json",
           "token" : myController.text
         }
     );
     print('PATIENTS EXECUTION');
     data = json.decode(response.body);
     if(data[0]['email'] != ''){
       print('patient existant');
       var url ='http://192.168.1.12:4000/user/AddAccessPatientMedecin';
       final prefs = await SharedPreferences.getInstance();
       var body = jsonEncode({
         'idpatient' : prefs.getString('idLoggedinUser'),
         'idmedecin' : data[0]['_id']  });
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
       result = 'Invitation Envoyer';
       print(result);
       return result ;
     }else{
       print('patient non existant');
       result = 'Patient Non Existant';
       print(result);
       return result ;
     }
  }
}



