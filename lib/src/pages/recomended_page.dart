import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login/src/pages/History.dart';
import 'package:flutter_login/src/pages/PatientsView.dart';
import 'package:flutter_login/src/pages/diagnosis.dart';
import 'carousel_slider.dart';

class RecommendedPage  extends StatefulWidget {
  RecommendedPage ({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<RecommendedPage > {
  int selectedIndex = 1;
  final widgetOptions = [
    Text('Beer List'),
    Text('Add new beer'),
    Text('Favourites'),
    Text('Favourites'),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan X-RAY'),
      ),
      body: Center(
     //   child: widgetOptions.elementAt(selectedIndex),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => {},
              color: Colors.deepPurpleAccent,
              padding: EdgeInsets.all(10.0),
              child: Column( // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.photo_camera),
                  Text("Scan XRAY")
                ],
              ),
            ),
            FlatButton(
              color: Colors.white,
              onPressed: () =>   Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Diagnosis(),
             // padding: EdgeInsets.all(10.0),
             // child: Column( // Replace with a Row for horizontal icon + text
               // children: <Widget>[
                 // Icon(Icons.show_chart),
                 // Text("Previous Scans"),
                //],
              ),
            )
            ,
            )],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text('')),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text(''))



        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped  ,
      ),
    );
  }

  void onItemTapped(int index) {
    print("selected index is  : ") ; print(index);
  if(index == 3){
    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new PatientsView())
    );
  }
    if(index == 2){
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) =>
          new MyCarousel())
      );
    }

    setState(() {
      selectedIndex = index;
    });
  }
}

