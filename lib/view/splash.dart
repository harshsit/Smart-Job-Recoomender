import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './onboardingpage.dart';
import './Root.dart';

import 'package:flutter_app/main.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String usertoken;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.getString("token") != null) 
     {
       setState(() {
         usertoken = prefs.getString("token");
       });
       print(usertoken);
     }
     else{
       print("error");
     }

    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) =>new  MainPage(usertok: usertoken,)));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) =>new OnboardingScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    new Timer(new Duration(seconds: 5), () {
      checkFirstSeen();
    });
    // super.initState();
    // checkFirstSeen();
    // Timer(Duration(seconds: 8), () => Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen())));

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: /* add child content here */
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 150.0,
                        child: Container(
                        decoration: BoxDecoration(
                       image: DecorationImage(
                        image: AssetImage("assets/grp19.png"),
                       fit: BoxFit.contain,
                       ),
                       ),
                        ), 
                      ),
                     Expanded(child: 
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10.0),
                      // ),
                      Container(
                        decoration: BoxDecoration(
                       image: DecorationImage(
                        image: AssetImage("assets/final.png"),
                       fit: BoxFit.fitWidth,
                       ),
                       ),
                        ), 
                  )
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 120.0,
                      //   child: Container(
                      //   decoration: BoxDecoration(
                      //  image: DecorationImage(
                      //   image: AssetImage("assets/final.png"),
                      //  fit: BoxFit.fitWidth,
                      //  ),
                      //  ),
                      //   ), 
                      // ),
                   
                     
                      // Text(
                      //   "CareerConnect",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 24.0),
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Your Search for Perfect Job Ends here",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    
    );
  }
}
