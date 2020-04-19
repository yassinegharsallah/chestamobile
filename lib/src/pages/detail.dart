import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListeMedecins.dart';
import 'package:http/http.dart' as http;
import 'RdvPatient.dart';
import 'Reminder/full_page_analog_time_picker.dart';
import 'TodoTask.dart';
import 'package:table_calendar/table_calendar.dart';

class MyDetailPage extends StatefulWidget {
  Medecin _Medc;
  String idpatient  ;
  MyDetailPage(Medecin Medc) {
    _Medc = Medc;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_Medc);
}
class RendezVous {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  RendezVous(this.img, this.title, this.body,this.idMedecin);
}
class _MyDetailPageState extends State<MyDetailPage> {
  Medecin Medc;
  CalendarController _controller;
  String availability = "intial";
  List<RendezVous> items = new List<RendezVous>();
  List data;
  List<String> TimeArray ;
  _MyDetailPageState(Medecin Medc) {
    this.Medc = Medc;
    _controller = CalendarController();

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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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

                    Future<String> getData(String date) async {
                      var response = await http.get(
                          Uri.encodeFull("http://192.168.1.12:4000/user/CheckDateAvailability"),
                          headers: {
                            "Accept": "application/json",
                            "token" : date
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
                    getData("2020-03-28T12:00:00.000+00:00").then((data){

                      for(int i=0 ; i<this.data.length;i++){
                        TimeArray.add('iiiiij') ;
                        //   print(i);
                        for(int i=0;i<TimeArray.length;i++){
                          print('Myriam');
                          print("Time aray num "+i.toString()+' '+TimeArray[i]) ;
                        }
                        items.add(new RendezVous("assets/images/hulk.png", this.data[i]["idpatient"], this.data[i]["idmedecin"],this.data[i]["date"]));
                      }
                    });

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
                new Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: new ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:this.items.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return   new Container(
                                padding: new EdgeInsets.only(top: 16.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.access_time,color: Colors.deepPurple),
                                    //items[index].idMedecin
                                    Text(items[index].idMedecin)
                                  ],
                                ));
                          },
                        ),
                      ),
                    ),
                    new IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: () {},
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),

              ],
            ),
          )


       /*   IconButton(
              icon: Icon(Icons.rate_review),
              color: Colors.blueAccent,
              onPressed: () async {
                // LOGIN GET REQUEST IS HERE
                var url ='http://192.168.1.12:4000/user/AddRdv';
                final prefs = await SharedPreferences.getInstance();
                var body = jsonEncode({
                  'idpatient' : prefs.getString('idLoggedinUser'),
                  'idmedecin' : this.Medc.idMedecin  });

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

                });.
                // LOGIN GET REQUEST IS HERE

      }),*/




        ],
      )),
    );
  }
}
