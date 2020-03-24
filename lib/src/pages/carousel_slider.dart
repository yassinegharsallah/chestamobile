import 'package:flutter/material.dart';
import 'package:carousel_widget/carousel_widget.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCarousel(),
    );
  }
}

class MyCarousel extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    initializeData();

    return Scaffold(
        backgroundColor: Colors.white,
        body:
        Carousel(

          listViews: [
            Fragment(
              child: getScreen(0),
            ),
            Fragment(
              child: getScreen(1),
            ),
            Fragment(
              child: getScreen(2),
            )
          ],
        )
       ,
    );

  }

  Widget getScreen(index) {
    return new ListView(
      children: <Widget>[
        new Container(
          height: 250.0,
          margin: const EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 0.0),
          child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/LungCACXR.PNG/300px-LungCACXR.PNG"),
          ),
        new Container(
          height: 45.0,
          margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
          child: Text(
            titles.elementAt(index),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20),
          ),
        ),
        new Container(
          height: 100.0,
          margin: const EdgeInsets.fromLTRB(50.0, 12.0, 50.0, 0.0),
          child: Text(
            description.elementAt(index),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  List<String> titles = List();
  List<String> description = List();
  List<String> imagenames = List();

  void initializeData() {
    titles.add("Title of First Screen");
    description.add("Description of First Screen");
    imagenames.add("assets/images/ecorp.png");

    titles.add("Title of Second Screen");
    description.add(
        "Description of Second Screen");
    imagenames.add("assets/images/ecorp.png");

    titles.add("Title of Third Screen");
    description.add(
        "Description of Third Screen");
    imagenames.add("assets/images/ecorp.png");
  }
}
