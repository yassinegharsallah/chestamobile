import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'History.dart' ;
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calendar(),
    );
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}
class RendezVous {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  RendezVous(this.img, this.title, this.body,this.idMedecin);
}
class _CalendarState extends State<Calendar> {
  CalendarController _controller;
//fetch data
  List<RendezVous> items = new List<RendezVous>();
  List data;



  _RendezVousMedecinState() {



    /* Fetching Data Into ListView */
  }
//fetch data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
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
                        return new Text(items[0].idMedecin);
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
      ),

    );
  }
}
