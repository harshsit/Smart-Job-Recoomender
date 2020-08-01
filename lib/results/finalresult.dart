 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/questions/question_level3_domain.dart';
import 'package:flutter_app/questions/question_level3_domain_model.dart';

 import 'dart:async';
 import 'dart:convert';
 import 'package:http/http.dart' as http;
 import 'package:shared_preferences/shared_preferences.dart';
 import 'package:flutter_app/view/dashboard.dart';
 import 'package:flutter_app/main.dart';
class ResDomPage extends StatefulWidget {
ResDomPage({Key key, this.resmarks1,this.resmarks2,this.round,this.previousround,this.maximum,this.token}) : super(key: key);
final int resmarks1;
final int resmarks2;
final String round;
final String previousround;
final String maximum;
final String token;


  _ResDomPageState createState() => _ResDomPageState();
}

class _ResDomPageState extends State<ResDomPage> {

 
  
  @override
  void initState() {  
    updatesubdommarks(widget.resmarks1.toString());
  super.initState();    
  }
 Future<void> updatesubdommarks(String b) async
  {
     
     
      
      String total =b.toString();
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       Map data = {
      'SubDomain': widget.maximum,
      'Total':total,
       };
       var jsonResponse = null;
       var response = await http.post("http://harshraj.pythonanywhere.com/candidate/put-sub-domain-marks/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.token}"});
       if(response.statusCode == 200)
       {
         jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("level 3 marks are applied");
       }
       else
       print("Error");

  }
  // Future<void> updateratingmmarks(String b) async
  // {  
  //   String rater;
  //    if(widget.maximum == '1')
  //    {
  //      rater = "put-ratingM";
  //    }
  //    else{
  //      rater = "put-ratingT";
  //    }
  //   String total = b;  
  //    Map data = {
  //     'SubDomain': widget.maximum,
  //     'Total':total,
  //      };
  //      var jsonResponse = null;
  //      var response = await http.post("http://harshraj.pythonanywhere.com/candidate/${rater}/", body: data,headers: {HttpHeaders.authorizationHeader:"token 4c136b7dbd75a637a1248db3be44c20a5a20a9ee"});
  //      if(response.statusCode == 200)
  //      {
  //        jsonResponse = json.decode(response.body);
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     print("Rating Marks Applied");
  //      }
  //      else
  //      print("Error");

  // }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //width / 1.2,
          child: Column(
            children: <Widget>[
            
              Expanded(
                flex: 8,
                child: Hero(
                  tag: 'Clipboard',
                  child:  Image(
                                image: AssetImage(
                                  'assets/profile.png',
                                ),
                                height: 100,
                                width: 100,
                              ),
                            
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    
                    Text(
                      'You have Completed ${widget.previousround} round',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'You are Recommended for SubDomain ${widget.maximum} Jobs' ,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'sanserrif.ttf'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Maximum in SubDomain ${widget.maximum}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: 'sanserrif.ttf'),
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  onPressed: () {
                    updatesubdommarks(widget.resmarks1.toString());
                    
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage(usertok: widget.token,subdom: widget.maximum,)),   /// HAVE TO WORK ON IT FOR DYNAMIC
                    );
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 60,
                    decoration: const BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: <Color>[
                      //     // CustomColors.GreenLight,
                      //     // CustomColors.GreenDark,
                      //     Colors.lightGreenAccent,
                      //     Colors.greenAccent,
                      //   ],
                      // ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                          offset: Offset(0.0, 0.0),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Center(
                      child: Text(
                        " You have completed Quiz",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  