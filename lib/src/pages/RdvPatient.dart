import 'dart:convert';
import 'package:flutter_login/src/pages/History.dart';
import 'package:flutter_login/src/pages/InvitationPatient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoTask.dart';
import 'RdvPatient.dart';
import 'package:flutter_login/src/pages/ChestaDoctor/ChestaDoctor.dart' ;
import 'package:table_calendar/table_calendar.dart';


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
  CalendarController _controller;
  _RendezVousPatientState() {
    /* Fetching Data Into ListView */
    _controller = CalendarController();

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
        print(this.items[index].idRendezVous);
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
          title: Text('Medecins')
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
                leading: Icon(Icons.assignment_ind),
                title: Text('Visiter Medecins'),
                onTap: ()=> {
                  /*      Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoronaDashboard()))*/
                }
            ),
            ListTile(
                leading: Icon(Icons.description),
                title: Text('Mes Rendez Vous'),
                onTap: ()=>
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RendezVousPatient(title: 'Rendez-Vous',)))
                }
            ),
            ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Suivis Hebdomadaire'),
                onTap: ()=>
                { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToDoListApp()))
                }),
            ListTile(
                leading: Icon(Icons.forum),
                title: Text('Invitations'),
                onTap: ()=>
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvitationMedecinPatient()))
                } ),

            ListTile(
                leading: Icon(Icons.history),
                title: Text('Historique'),
                onTap: ()=> {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => History()))
                }),
            ListTile(
                leading: Icon(Icons.streetview),
                title: Text('Chesta Doctor'),
                onTap: ()=> {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChestaDoctor()))
                })
          ],
        ),

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                String SelectedDate = date.toString();
                /* Fetching Data Into ListView */
/*
                Future<String> getData(String id) async {
                  var response = await http.get(
                      Uri.encodeFull("http://192.168.1.12:4000/user/GetRdvByDate"),
                      headers: {
                        "Accept": "application/json",
                        "token" : id
                      }
                  );

                  this.setState(() {
                    print(response.body);
                    this.data = json.decode(response.body);
                  });


                  return "Success";
                }

                // await getData()  ;  // <--- your code needs to pause until the Future returns.
                print('S7SSSSSS W SOUSOU');
                getData(date.toIso8601String()
                ).then((data){
                  for(int i=0 ; i<this.data.length;i++){
                    print(this.data[i]["_id"]);
                    //   print(i);
                    items.add(new RendezVous("assets/images/hulk.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["_id"]));
                  }
                });
*/
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: ((context, index) => MedcCell(context, index)
                ),
              ),
            )],
        ),
      ),
    );
  } // This trailing comma makes auto-formatting nicer for build methods.




 /* @override
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
  }  */

}
