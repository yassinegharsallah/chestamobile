import 'package:flutter/material.dart';
import 'package:flutter_login/home_page.dart';

import 'Dashboard.dart';
import 'addPatient.dart';


class PatientsView extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final title = 'Patients List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),

        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Patient 1')
                , onTap: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ))
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Patient 2'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Patient 3'),
            ),
            RaisedButton(
              child: Text("ADD PATIENT"),
              onPressed: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProfilePage(),
            )
              )),
            RaisedButton(
                child: Text("DASHBOARD"),
                onPressed: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ExampleApp(),
                )
                ))
          ],


        ),

      ),

    );

  }
  /*_changeText(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainActivity(),
    ));}*/

}
