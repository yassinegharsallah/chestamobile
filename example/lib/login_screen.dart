
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'constants.dart';
import 'custom_route.dart';
import 'users.dart';
import 'package:flutter_login/src/pages/home_page.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/src/pages/ListeMedecins.dart';
import 'package:flutter_login/src/pages/RendezVousMedecin.dart' ;

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  /*Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 6000000);

  Future<String> _loginUser(LoginData data) {

    return Future.delayed(loginTime).then((_) {
   if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });

  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: 'assets/images/ecorp.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      // messages: LoginMessages(
      //   usernameHint: 'Username',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'LOG IN',
      //   signupButton: 'REGISTER',
      //   forgotPasswordButton: 'Forgot huh?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',
      //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
      //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
      //   recoverPasswordSuccess: 'Password rescued successfully',
      // ),
      // theme: LoginTheme(
      //   primaryColor: Colors.teal,
      //   accentColor: Colors.yellow,
      //   errorColor: Colors.deepOrange,
      //   pageColorLight: Colors.indigo.shade300,
      //   pageColorDark: Colors.indigo.shade500,
      //   titleStyle: TextStyle(
      //     color: Colors.greenAccent,
      //     fontFamily: 'Quicksand',
      //     letterSpacing: 4,
      //   ),
      //   // beforeHeroFontSize: 50,
      //   // afterHeroFontSize: 20,
      //   bodyStyle: TextStyle(
      //     fontStyle: FontStyle.italic,
      //     decoration: TextDecoration.underline,
      //   ),
      //   textFieldStyle: TextStyle(
      //     color: Colors.orange,
      //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
      //   ),
      //   buttonStyle: TextStyle(
      //     fontWeight: FontWeight.w800,
      //     color: Colors.yellow,
      //   ),
      //   cardTheme: CardTheme(
      //     color: Colors.yellow.shade100,
      //     elevation: 5,
      //     margin: EdgeInsets.only(top: 15),
      //     shape: ContinuousRectangleBorder(
      //         borderRadius: BorderRadius.circular(100.0)),
      //   ),
      //   inputTheme: InputDecorationTheme(
      //     filled: true,
      //     fillColor: Colors.purple.withOpacity(.1),
      //     contentPadding: EdgeInsets.zero,
      //     errorStyle: TextStyle(
      //       backgroundColor: Colors.orange,
      //       color: Colors.white,
      //     ),
      //     labelStyle: TextStyle(fontSize: 12),
      //     enabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //     errorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
      //       borderRadius: inputBorder,
      //     ),
      //     focusedErrorBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
      //       borderRadius: inputBorder,
      //     ),
      //     disabledBorder: UnderlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey, width: 5),
      //       borderRadius: inputBorder,
      //     ),
      //   ),
      //   buttonTheme: LoginButtonTheme(
      //     splashColor: Colors.purple,
      //     backgroundColor: Colors.pinkAccent,
      //     highlightColor: Colors.lightGreen,
      //     elevation: 9.0,
      //     highlightElevation: 6.0,
      //     shape: BeveledRectangleBorder(
      //       borderRadius: BorderRadius.circular(10),
      //     ),
      //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
      //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
      //   ),
      // ),
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';

        }
        return null;
      },
      onLogin: (loginData) async {
        print('Login info');
        // LOGIN GET REQUEST IS HERE
        //AlexandertttTrent@esprit.tn
        //dshd58dfdfdfd
        var url ='http://192.168.1.12:4000/user/login';
        var body = jsonEncode({
          'email' : loginData.name,
          'password' : loginData.password  });

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
          var parsedJson = json.decode(response.body);
          if(parsedJson['token']!= null){
            String urlLogin = 'http://192.168.1.12:4000/user/me';
            Response GetLoginResponse = await get(urlLogin,headers: {"Content-type": "application/json","token":parsedJson['token']});
            print("********** LOGGED IN USER ***********")  ;
            print(GetLoginResponse.body);
            /*save into shared pref*/
            var parsedBody = json.decode(GetLoginResponse.body);

            final prefs = await SharedPreferences.getInstance();
            prefs.setString('username',parsedBody['username']);
            prefs.setString('email', parsedBody['email']) ;
            prefs.setString('idLoggedinUser',parsedBody['_id']) ;
            /*save into shared pref*/
             //redirection after login
              if(parsedBody['email'] == 'med@gmail.com'){
                print('Medecin');
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new RendezVousMedecin(title: 'Rendez-Vous',))
                );
              }else{
                print('Patient');
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new ListeMedecins(title : 'Title'))
                );
              }
             //redirection after login


          }else{
            print('wrong login credentials');
          }

          //JSON DECODER

        });
        // LOGIN GET REQUEST IS HERE



      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) =>
            new HomePagex())
        );
      },
      onSubmitAnimationCompleted: () {

      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
      //  return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: true,
    );
  }
}
