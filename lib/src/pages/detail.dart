import 'package:flutter/material.dart';

import 'ListeMedecins.dart';

class MyDetailPage extends StatefulWidget {
  Medecin _Medc;

  MyDetailPage(Medecin Medc) {
    _Medc = Medc;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_Medc);
}

class _MyDetailPageState extends State<MyDetailPage> {
  Medecin Medc;

  _MyDetailPageState(Medecin Medc) {
    this.Medc = Medc;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(Medc.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: Medc,
            child: Transform.scale(
              scale: 2.0,
              child: Image.asset(Medc.img),
            ),
          ),
          Card(
            elevation: 8,
            margin: EdgeInsets.all(16),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(Medc.body),
            ),
          ),
          IconButton(
              icon: Icon(Icons.rate_review),
              color: Colors.blueAccent,
              onPressed: (){

      })
      ,
        ],
      )),
    );
  }
}
