import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:flutter_login/src/pages/ChestaDoctor/Resultat.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

QuizBrain quizBrain = QuizBrain();

class ChestaDoctor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  List<String> QuestionsResults = [] ;
  static double finalscore =1 ;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                bool result = quizBrain.getCorrectAnswer();
                setState(() async {
//                  scoreKeeper.add(
//                    Icon(
//                      Icons.check,
//                      color: Colors.green,
//                    ),
//                  );
              int x = quizBrain.nextQuestion();
              finalscore = finalscore * 7.5;
              print("you clicked true "+x.toString()+" score now"+finalscore.toString());
              this.QuestionsResults.add('true');
             if(x == 5){
               //add score
               final prefs = await SharedPreferences.getInstance();
               prefs.setDouble('score',finalscore);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Resultat(this.QuestionsResults)));
              }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),

              onPressed: () {
                bool result = quizBrain.getCorrectAnswer();
                setState(() async {
//                  scoreKeeper.add(
//                    Icon(
//                      Icons.check,
//                      color: Colors.green,
//                    ),
//                  );
                  int x = quizBrain.nextQuestion();
                  finalscore += finalscore * 7.5;
                  print("you clicked false "+x.toString()+" score now"+finalscore.toString());
                  this.QuestionsResults.add('true');
                    if(x == 5){
                //add score
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setDouble('score',finalscore);
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Resultat(this.QuestionsResults)));
              }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
