import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/pages/AccessPatient.dart';
import 'package:flutter_login/src/pages/SuivrePatient.dart';

class MedecinPatients extends StatefulWidget {
  MedecinPatients({Key key}) : super(key: key);

  @override
  _MedecinPatientsState createState() => _MedecinPatientsState();
}

class _MedecinPatientsState extends State<MedecinPatients> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mes Patients'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              RaisedButton(
                child: Text("Acceder Patients"),
                onPressed: () =>  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccessPatient())),
                color: Colors.blueAccent,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              ),
              RaisedButton(
                child: Text("Suivre Patients"),
                onPressed: () =>  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuivrePatient() )),
                color: Colors.blueAccent,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                splashColor: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }


}
