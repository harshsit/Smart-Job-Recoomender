// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'package:flutter_app/view/login.dart';
// import 'package:flutter_app/view/homepage.dart';
// import 'package:flutter_app/main.dart';



// enum AuthStatus {
//   NOT_DETERMINED,
//   NOT_LOGGED_IN,
//   LOGGED_IN,
// }

// class RootPage extends StatefulWidget {
//   RootPage({this.auth});

//   final String auth;

//   @override
//   State<StatefulWidget> createState() => new _RootPageState();
// }

// class _RootPageState extends State<RootPage> {
//   AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
//   String token;
//   checkLoginStatus() async {
//     var sharedPreferences = await SharedPreferences.getInstance();
//     if(sharedPreferences.getString("token") == null) {
//       setState(() {
//           authStatus = AuthStatus.NOT_LOGGED_IN;
//          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
//       });
//    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
//     }
//     else
//    token= sharedPreferences.getString("token");
//    setState(() {
//       authStatus = AuthStatus.LOGGED_IN;
//      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
//    });
   
  

//   }

//   @override
//   void initState() {
//     super.initState();
//     checkLoginStatus();

//     // widget.auth.getCurrentUser().then((user) {
//     //   setState(() {
//     //     if (user != null) {
//     //       _userId = user?.uid;
//     //     }
//     //     authStatus =
//     //         user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
//     //   });
//     // });
//   }

//   // void loginCallback() {
//   //   widget.auth.getCurrentUser().then((user) {
//   //     setState(() {
//   //       _userId = user.uid.toString();
//   //     });
//   //   });
//   //   setState(() {
//   //     authStatus = AuthStatus.LOGGED_IN;
//   //   });
//   // }

//   void logoutCallback() {
//     setState(() {
//       authStatus = AuthStatus.NOT_LOGGED_IN;
      
//     });
//   }

//   Widget buildWaitingScreen() {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (authStatus) {
//       case AuthStatus.NOT_DETERMINED:
//         return buildWaitingScreen();
//         break;
//       case AuthStatus.NOT_LOGGED_IN:
//         return new LoginPage(
          
         
//         );
//         break;
//       case AuthStatus.LOGGED_IN:
//         if (token.length > 0 && token != null) {
//           return new MainPage(
//           usertok: token,
//           );
//         } else
//           return buildWaitingScreen();
//         break;
//       default:
//         return buildWaitingScreen();
//     }
//   }
// }
