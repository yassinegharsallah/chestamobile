import 'package:flutter/material.dart';


class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: new MyHomePage(title: 'Historique X-RAY'),
    );
  }
}
class Place {
  String imageUrl;
  String name;
  String country;

  Place({this.imageUrl, this.name, this.country});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          children: [
            Image.network('https://prod-images-static.radiopaedia.org/images/8686421/17baee9bfb9018e3d109ec63cb380e_jumbo.jpeg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            ListTile(
                leading: Icon(Icons.date_range),
                title: Text('12/05/2018'),
            ),
            Image.network('https://prod-images-static.radiopaedia.org/images/8686421/17baee9bfb9018e3d109ec63cb380e_jumbo.jpeg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),

            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('19/05/2018'),
            ),
            Image.network('https://prod-images-static.radiopaedia.org/images/8686421/17baee9bfb9018e3d109ec63cb380e_jumbo.jpeg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('22/05/2018'),
            ),
            Image.network('https://prod-images-static.radiopaedia.org/images/8686421/17baee9bfb9018e3d109ec63cb380e_jumbo.jpeg',
              width: 600.0,
              height: 240.0,
              fit: BoxFit.cover,),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('10/05/2018'),
            ),          ],

        ),
      ),
    );
  }
}