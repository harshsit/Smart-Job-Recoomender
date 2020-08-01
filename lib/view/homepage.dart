import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'Animation/fade_animation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/view/profile.dart';

import 'package:flutter_app/view/homepage.dart';
import 'package:flutter_app/view/candidate.dart';
import 'package:flutter_app/view/university.dart';
import 'package:flutter_app/view/organization.dart';
import 'package:flutter_app/view/login.dart';

import '../main.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool usertype1 = false;
  bool usertype2 = false;
  bool usertype3 = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirm_passwordController = new TextEditingController();

 bool _isLoading = false;
// signIn(String username, password) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     Map data = {
//       'username': username,
//       'password': password
//     };
//     var jsonResponse = null;

//     var response = await http.post(
//         "https://harshraj.pythonanywhere.com/account/login/", body: data);
//     if (response.statusCode == 200) {
//       jsonResponse = json.decode(response.body);
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       if (jsonResponse != null) {
//         setState(() {
//           _isLoading = false;
//         });
//         sharedPreferences.setString("token", jsonResponse['token']);
//         sharedPreferences.setString("user", username);
//         String tk = sharedPreferences.getString("token");
//         print(tk);
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (BuildContext context) => FadeAnimation(1,ProfilePage(tok: tk,))), (
//             Route<dynamic> route) => false);
//       }
//     }
//     else {
//       setState(() {
//         _isLoading = false;
//       });
//       print(response.body);
//     }
//   }

  signUp(String email, String username, String password,
      String confirm_password, String Is_Candidate, String Is_University,
      String Is_Organization) async {
    Map data = {
      'email': email,
      'username': username,
      'password': password,
      'confirm_password': confirm_password,
      'Is_Candidate': Is_Candidate,
      'Is_University': Is_University,
      'Is_Organization': Is_Organization,
    };

    var jsonResponse = null;

    var response = await http.post(
        "https://harshraj.pythonanywhere.com/account/registration/", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (jsonResponse != null) {
        setState(() {

          Navigator.pop(context);
          //      Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (
          //       Route<dynamic> route) => false);
          // }
          // _isLoading = false;
          //  showDialog(context: jsonResponse);
           if("${jsonResponse['status']}" == 'true')
                    {
                          print(jsonResponse['status']);
                    }
            else{
          showCupertinoDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("ALERT"),
              content: new Text("${jsonResponse['message']} \n ${jsonResponse['data']}"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Dismiss"),
                  onPressed: () {
                    if("${jsonResponse['sucess']}" == 'true')
                    {
                       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FadeAnimation(0.0,ProfilePage(user: username,password: password,))), (Route<dynamic> route) => false);
                          //signIn(username, password);
                         // Navigator.of(context).pop();
                    }
                    else{

                    
                    Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });}
        });
      }
      else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);

      }

    }
    else
    {
      print("error");

    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       
        resizeToAvoidBottomPadding: false,
      
        body: 
         _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                
                FadeAnimation(1,
                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                  child: Text(
                    'Signup',
                    style:
                    TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
                  ),
                ),
                ),
                FadeAnimation(1.3,
                Container(
                  padding: EdgeInsets.fromLTRB(260.0, 125.0, 0.0, 0.0),
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[200]),
                  ),
                ),
                ),
              ],
            ),
          ),
         FadeAnimation(1.5,
          Container(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller:emailController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        // hintText: 'EMAIL',
                        // hintStyle: ,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:usernameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: 'USERNAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),

                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:passwordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: 'PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller:confirm_passwordController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: 'CONFIRM PASSWORD ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                    obscureText: true,
                  ),
                  SizedBox(height: 10.0),
               CheckboxListTile(title:Text("Candidate") ,value: usertype1,activeColor: Colors.tealAccent ,onChanged: (bool newValue) {
                setState(() {
                usertype1 = newValue;
                 });
                  },
                 controlAffinity: ListTileControlAffinity.leading,),
                  SizedBox(height: 10.0),

                  Container(
                      height: 30.0,

                    width: MediaQuery.of(context).size.width,

                    color: Colors.deepPurple,

//                   padding: EdgeInsets.symmetric(horizontal: 15.0),
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                     onPressed:emailController.text == "" || passwordController.text == "" || usernameController.text =="" || confirm_passwordController.text =="" ||  usertype1 =="" ||usertype2 =="" || usertype3 == ""? null : () {
                     setState(() {
                     _isLoading = true;
                       });
                      signUp(emailController.text,usernameController.text,passwordController.text,confirm_passwordController.text,usertype1.toString(),usertype2.toString(),usertype3.toString());
                     },
                      elevation: 0.0,
                      color: Colors.greenAccent,
                      child: Text("Sign In", style: TextStyle(color: Colors.white)),
                      shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20.0),),
                    ),
                     ),
                  SizedBox(height: 20.0),
//                  Container(
//                    height: 40.0,
//                    color: Colors.transparent,
//                    child: Container(
//                      decoration: BoxDecoration(
//                          border: Border.all(
//                              color: Colors.black,
//                              style: BorderStyle.solid,
//                              width: 1.0),
//                          color: Colors.transparent,
//                          borderRadius: BorderRadius.circular(20.0)),
//                      child: InkWell(
//                        onTap: () {
//                          Navigator.of(context).pop();
//                        },
//                        child:
//
//                        Center(
//                          child: Text('Go Back',
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  fontFamily: 'Montserrat')),
//                        ),
//
//
//                      ),
//                    ),
//                  ),
                ],
              ))),
          // SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       'New to Spotify?',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //       ),
          //     ),
          //     SizedBox(width: 5.0),
          //     InkWell(
          //       child: Text('Register',
          //           style: TextStyle(
          //               color: Colors.green,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //               decoration: TextDecoration.underline)),
          //     )
          //   ],
          // )
        ]
    ));
  }
}
//class SignUpPage extends StatefulWidget {
//  @override
//  _SignUpPageState createState() => _SignUpPageState();
//}
//
//class _SignUpPageState extends State<SignUpPage> {
//  bool usertype1 = false;
//  bool usertype2 = false;
//  bool usertype3 = false;
//
//  bool _isLoading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//        statusBarColor: Colors.transparent));
//    return Scaffold(
//      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//              colors: [Colors.white, Colors.white],
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter),
//        ),
//        child: _isLoading
//            ? Center(child: CircularProgressIndicator())
//            : ListView(
//          children: <Widget>[
//            headerSection(),
//            textSection(),
//            buttonSection(),
//
//          ],
//        ),
//      ),
//    );
//  }
//  signUp(String email, String username, String password,
//      String confirm_password, String Is_Candidate, String Is_University,
//      String Is_Organization) async {
//    Map data = {
//      'email': email,
//      'username': username,
//      'password': password,
//      'confirm_password': confirm_password,
//      'Is_Candidate': Is_Candidate,
//      'Is_University': Is_University,
//      'Is_Organization': Is_Organization,
//    };
//
//    var jsonResponse = null;
//
//    var response = await http.post(
//        "https://harshraj.pythonanywhere.com/account/registration/", body: data);
//    if (response.statusCode == 200) {
//      jsonResponse = json.decode(response.body);
//      print('Response status: ${response.statusCode}');
//      print('Response body: ${response.body}');
//      if (jsonResponse != null) {
//        setState(() {
//
//          Navigator.pop(context);
//          //      Navigator.of(context).pushAndRemoveUntil(
//          //       MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (
//          //       Route<dynamic> route) => false);
//          // }
//          // _isLoading = false;
//          //  showDialog(context: jsonResponse);
//          showCupertinoDialog(context: context, builder: (BuildContext context) {
//            return AlertDialog(
//              title: new Text("ALERT"),
//              content: new Text(jsonResponse['message'] ),
//              actions: <Widget>[
//                // usually buttons at the bottom of the dialog
//                new FlatButton(
//                  child: new Text("Dismiss"),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//                  },
//                ),
//              ],
//            );
//          });
//        });
//      }
//      else {
//        setState(() {
//          _isLoading = false;
//        });
//        print(response.body);
//
//      }
//
//    }
//    else
//    {
//      print("error");
//
//    }
//  }
//
//  Container buttonSection() {
//    return Container(
//
//      padding: EdgeInsets.symmetric(horizontal: 15.0),    // Is_CandidateController.text == ""
//      margin: EdgeInsets.only(top: 15.0),
//      child: RaisedButton(
//        onPressed:emailController.text == "" || passwordController.text == "" || usernameController.text =="" || confirm_passwordController.text =="" ||  usertype1 =="" ||usertype2 =="" || usertype3 == ""? null : () {
//          setState(() {
//            _isLoading = true;
//          });
//          signUp(emailController.text,usernameController.text,passwordController.text,confirm_passwordController.text,usertype1.toString(),usertype2.toString(),usertype3.toString());
//        },
//        elevation: 0.0,
//        color: Colors.greenAccent,
//        child: Text("Sign Up", style: TextStyle(color: Colors.black)),
//        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//      ),
//    );
//  }
//  final TextEditingController emailController = new TextEditingController();
//  final TextEditingController usernameController = new TextEditingController();
//  final TextEditingController passwordController = new TextEditingController();
//  final TextEditingController confirm_passwordController = new TextEditingController();
//  // final TextEditingController Is_CandidateController = new TextEditingController();
//  // final TextEditingController Is_UniversityController = new TextEditingController();
//  // final TextEditingController Is_OrganizationController = new TextEditingController();
//
//
//
//
//  Container textSection() {
//
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
//
//      child: Column(
//        children: <Widget>[
//          TextFormField(
//            controller: emailController,
//            cursorColor: Colors.white,
//
//            style: TextStyle(color: Colors.black),
//            decoration: InputDecoration(
//              icon: Icon(Icons.email, color: Colors.black),
//              hintText: "Email",
//              border: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.black)),
//              hintStyle: TextStyle(color: Colors.black),
//            ),
//          ),
//          SizedBox(height: 30.0),
//          TextFormField(
//            controller: usernameController,
//            cursorColor: Colors.white,
//
//            style: TextStyle(color: Colors.black),
//            decoration: InputDecoration(
//              icon: Icon(Icons.person, color: Colors.black),
//              hintText: "username",
//              border: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.black)),
//              hintStyle: TextStyle(color: Colors.black),
//            ),
//          ),
//
//          SizedBox(height: 30.0),
//          TextFormField(
//            controller: passwordController,
//            cursorColor: Colors.white,
//            obscureText: true,
//            style: TextStyle(color: Colors.black),
//            decoration: InputDecoration(
//              icon: Icon(Icons.lock, color: Colors.black),
//              hintText: "Password",
//              border: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.black)),
//              hintStyle: TextStyle(color: Colors.black),
//            ),
//          ),
//          SizedBox(height: 20.0),
//          TextFormField(
//            controller: confirm_passwordController,
//            cursorColor: Colors.white,
//            obscureText: true,
//            style: TextStyle(color: Colors.black),
//            decoration: InputDecoration(
//              icon: Icon(Icons.lock, color: Colors.black),
//              hintText: "Confirm Password",
//              border: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.black)),
//              hintStyle: TextStyle(color: Colors.black),
//            ),
//          ),
//          SizedBox(height: 10.0),
//          CheckboxListTile(title:Text("Candidate") ,value: usertype1,activeColor: Colors.tealAccent ,onChanged: (bool newValue) {
//            setState(() {
//              usertype1 = newValue;
//            });
//          },
//            controlAffinity: ListTileControlAffinity.leading,),
//          CheckboxListTile(title:Text("University") ,value: usertype2,activeColor: Colors.tealAccent ,onChanged: (bool newValue) {
//            setState(() {
//              usertype2 = newValue;
//            });
//          },
//            controlAffinity: ListTileControlAffinity.leading,),
//          CheckboxListTile(title:Text("Organization") ,value: usertype3,activeColor: Colors.tealAccent ,onChanged: (bool newValue) {
//            setState(() {
//              usertype3 = newValue;
//            });
//          },
//            controlAffinity: ListTileControlAffinity.leading,),
//
//          // TextFormField(
//          //   controller: Is_CandidateController,
//          //   cursorColor: Colors.white,
//
//          //   style: TextStyle(color: Colors.black),
//          //   decoration: InputDecoration(
//          //     icon: Icon(Icons.lock, color: Colors.black),
//          //     hintText: "Candidate",
//          //     border: UnderlineInputBorder(
//          //         borderSide: BorderSide(color: Colors.black)),
//          //     hintStyle: TextStyle(color: Colors.black),
//          //   ),
//          // ),
//          // TextFormField(
//          //   controller: Is_UniversityController,
//          //   cursorColor: Colors.white,
//
//          //   style: TextStyle(color: Colors.black),
//          //   decoration: InputDecoration(
//          //     icon: Icon(Icons.lock, color: Colors.black),
//          //     hintText: "University",
//          //     border: UnderlineInputBorder(
//          //         borderSide: BorderSide(color: Colors.black)),
//          //     hintStyle: TextStyle(color: Colors.black),
//          //   ),
//          // ),
//          // TextFormField(
//          //   controller: Is_OrganizationController,
//          //   cursorColor: Colors.white,
//
//          //   style: TextStyle(color: Colors.black),
//          //   decoration: InputDecoration(
//          //     icon: Icon(Icons.lock, color: Colors.black),
//          //     hintText: "Organization",
//          //     border: UnderlineInputBorder(
//          //         borderSide: BorderSide(color: Colors.black)),
//          //     hintStyle: TextStyle(color: Colors.black),
//          //   ),
//          // ),
//          // CheckboxListTile(title:Text("Caandidate") ,value: usertype,activeColor: Colors.tealAccent ,onChanged: (bool newValue) {
//          //  setState(() {
//          //   usertype = newValue;
//          //  });
//          // },
//          // controlAffinity: ListTileControlAffinity.leading,)
//
//
//
////          MyStatefulWidget(),
////
////         University(),
//////         SizedBox(height: 10.0),
//////         SizedBox(height: 10.0),
////        Organization(),
//
//
//        ],
//      ),
//
//    );
//  }
//}
//
//
//
//
//Container headerSection() {
//  return Container(
//    margin: EdgeInsets.only(top: 10.0),
//    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
//    child: Text("Sign Up",
//        style: TextStyle(
//            color: Colors.black,
//            fontSize: 40.0,
//            fontWeight: FontWeight.bold)),
//  );
//}
//
