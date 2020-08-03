import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/view/homepage.dart';
import 'Animation/fade_animation.dart';


import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    bool _isLoading = false;
    final TextEditingController emailController = new TextEditingController();
    final TextEditingController passwordController = new TextEditingController();

    signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password
    };
    var jsonResponse = null;

    var response = await http.post(
        "https://harshraj.pythonanywhere.com/account/login/", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("user", username);
        String tk = sharedPreferences.getString("token");
        print(tk);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage(usertok: tk,)), (
            Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,

        body:
       
          _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                 FadeAnimation(1, 
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text('Hello',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
              ),
              FadeAnimation(1.3,
                  Container(
                    padding: EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                    child: Text('There',
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold)),
                  ),
              ),
              FadeAnimation(1.5,
                  Container(
                    padding: EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                    child: Text('.',
                        style: TextStyle(
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[200])),
                  ),
              ),
                ],
              ),
            ),
            FadeAnimation(2,
            Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          labelText: 'USERNAME',

                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                              keyboardType: TextInputType.emailAddress,

                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: passwordController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 5.0),
                    // Container(
                    //   alignment: Alignment(1.0, 0.0),
                    //   padding: EdgeInsets.only(top: 15.0, left: 20.0),
                    //   child: InkWell(
                    //     child: Text(
                    //       'Forgot Password',
                    //       style: TextStyle(
                    //           color: Colors.deepPurple[200],
                    //           fontWeight: FontWeight.bold,
                    //           fontFamily: 'Montserrat',
                    //           decoration: TextDecoration.underline),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width,

                      color: Colors.deepPurple[200],


//                   padding: EdgeInsets.symmetric(horizontal: 15.0),
                   margin: EdgeInsets.only(top: 10.0),
                     child: RaisedButton(
                         onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
                         setState(() {
                         _isLoading = true;
                               });
                        signIn(emailController.text, passwordController.text);
                        },
                       elevation: 0.0,
                        color: Colors.deepPurple[200],
                        child: Text("Sign In", style: TextStyle(color: Colors.white)),
                       shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20.0),),
                     ),
//
//
//                      child: Material(
//                        borderRadius: BorderRadius.circular(20.0),
//                        shadowColor: Colors.greenAccent,
//
//                        color: Colors.green,
//                        elevation: 7.0,
////                        child: GestureDetector(
////
////                          onTap: emailController.text == "" || passwordController.text == "" ? null : () {
////                          setState(() {
////                           _isLoading = true;
////                            });
////                           signIn(emailController.text, passwordController.text);
////                            },
////                          child: Text(
////                              'LOGIN',
////                              style: TextStyle(
////                                  color: Colors.white,
////                                  fontWeight: FontWeight.bold,
////                                  fontFamily: 'Montserrat'),
////                            ),
////                        ),
//
//
//                          child: Center(
//                            child: FlatButton(
//                              onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
//                                setState(() {
//                                  _isLoading = true;
//                                });
//                                signIn(emailController.text, passwordController.text);
//                              },
//                              child:Text(
//                              'LOGIN',
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontFamily: 'Montserrat'),
//                            ),
//
//                            ),
//                          ),
//
//
//                      ),

                    ),
                    SizedBox(height: 20.0),
//                     Container(
//                       height: 40.0,
//                       color: Colors.transparent,
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 color: Colors.black,
//                                 style: BorderStyle.solid,
//                                 width: 1.0),
//                             color: Colors.transparent,
//                             borderRadius: BorderRadius.circular(20.0)),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
// //                            Center(
// //                              child:
// //                              ImageIcon(AssetImage('assets/google.gif')),
// //                            ),
//                             SizedBox(width: 10.0),
//                             Center(
//                               child: Text('Log in with Google',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily: 'Montserrat')),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
                  ],
                )),),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'New to CareerConnect ?',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
                SizedBox(width: 5.0),
               FadeAnimation(1, InkWell(
                  onTap: () {
                    Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => SignupPage(),),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.deepPurple[200],
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                )
               ),
              ],
            )
          ],
        ),);
  }
}


