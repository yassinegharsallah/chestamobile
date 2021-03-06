import 'dart:convert';
import 'package:flutter_login/src/CoronaDashboard/main.dart';
import 'package:flutter_login/src/pages/History.dart';
import 'package:flutter_login/src/pages/InvitationPatient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TodoTask.dart';
import 'RdvPatient.dart';
import 'package:flutter_login/src/pages/ChestaDoctor/ChestaDoctor.dart' ;

class ListeMedecins extends StatefulWidget {
  ListeMedecins({Key key, this.title}) : super(key: key);
  final String title;


  @override
  _ListeMedecinsState createState() => _ListeMedecinsState();
}

class Medecin {
  final String img;
  final String title;
  final String body;
  final String idMedecin ;

  Medecin(this.img, this.title, this.body,this.idMedecin);
}

class _ListeMedecinsState extends State<ListeMedecins> {
  List<Medecin> items = new List<Medecin>();
 List data;



  _ListeMedecinsState() {
    /* Fetching Data Into ListView */

    Future<String> getData() async {
      var response = await http.get(
          Uri.encodeFull("http://192.168.1.65:4000/user/GetAllMedecins"),
          headers: {
            "Accept": "application/json"
          }
      );

      this.setState(() {

        this.data = json.decode(response.body);
      });


      return "Success";
    }


   // await getData()  ;  // <--- your code needs to pause until the Future returns.
    print('GET  DATA GET ');
    getData().then((data){
      for(int i=0 ; i<this.data.length;i++){
        print(this.data[i]["email"]);
        print(i);
        items.add(new Medecin("assets/images/doctor.png", this.data[i]["nom"], this.data[i]["email"],this.data[i]["_id"]));
      }
    });


    /* Fetching Data Into ListView */
  }

  Future<String>  getSearchData(nomMedecin) async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.65:4000/user/GetMedecinByNom"),
        headers: {
          "Accept": "application/json",
          "token": nomMedecin
        }
    );

    this.setState(() {

      this.data = json.decode(response.body);
    });
print(data);

    return "Success";
  }

  void filterSearchResults(String query) {
   print('Searched Query is '+query);
  getSearchData(query).then((data){
     for(int i=0 ; i<this.data.length;i++){
       print('searched results');
       print(this.data[i]["email"]);
       items.clear();
       items.add(new Medecin("assets/images/doctor.png", this.data[i]["nom"], this.data[i]["email"],this.data[i]["_id"]));
     }
   });

  }


  Widget MedcCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        final username = prefs.getString('username');
        final email = prefs.getString('email');
        final idLoggedInuser = prefs.getString('idLoggedinUser');
        print(username);
        print(email) ;
        print("id Logged in user : "+idLoggedInuser) ;
        final snackBar = SnackBar(content: Text("Tap"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(items[index])));
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
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                     'Dr ' + items[index].title,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visiter Medecin')
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
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
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CoronaDashboard()))
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
              title: Text('Mon Suivi Quotidien'),
                onTap: ()=>
                { Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ToDoListApp()))
                }),
            ListTile(
              leading: Icon(Icons.forum),
              title: Text('Invitations Acces Medecin'),
                onTap: ()=>
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvitationMedecinPatient()))
                } ),

            ListTile(
                leading: Icon(Icons.history),
                title: Text('Historique Rendez-vous'),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                 filterSearchResults(value);
                },
               // controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
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

  }


