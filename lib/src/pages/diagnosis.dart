import 'package:flutter/material.dart';
import 'package:flutter_login/home_page.dart';

import 'addPatient.dart';

void main() => runApp(Diagnosis());

class Diagnosis extends StatelessWidget {
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
                leading: Icon(Icons.show_chart),
                title: Text('98% True                  75% False')
                , onTap: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ))
            ),
            ListTile(
              leading: Icon(Icons.recent_actors),
              title: Text('PNEUMONIA STATUS : INFECTED'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Patient 3'),
            ),
            RaisedButton(
                child: Text("Confirm Results"),
                color: Colors.blue,
                onPressed: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                )
                ))],


        ),

      ),

    );

  }
/*_changeText(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainActivity(),
    ));}*/

}
