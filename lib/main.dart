import 'dart:ffi';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter_app/view/login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/view/splash.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/view/whatson_chatbot.dart';
import 'package:flutter_app/view/dashboard.dart';
import 'package:flutter_app/view/profile.dart';

import 'package:flutter_app/view/Animation/fade_animation.dart';


import 'view/profile.dart';

import 'package:flutter_app/view/viewProfile.dart';
import 'package:responsive_framework/responsive_framework.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    return MaterialApp(

      title: "CareerConnect",
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 400,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(400, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
           
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Colors.deepPurple)),
        //  theme: Theme.of(context).copyWith(platform: TargetPlatform.android),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),//MainPage(),
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
    MainPage({Key key, this.usertok,this.dom,this.subdom,this.rate}) : super(key: key);
   final String usertok;
  
   final String dom;
   final String subdom;
   final String rate;
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool verifyprofile = false;
 
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

 String hj,kj;
  SharedPreferences sharedPreferences;

//  signOut() async {
//     try {
      
//       widget.logoutCallback();
//     } catch (e) {
//       print(e);
//     }
//   }
  @override
  void initState() {
    //super.initState();
    checkLoginStatus();
    profileverify();
    super.initState();
  }
Future<void> profileverify() async {
 if(widget.usertok != null)
 {
   if(verifyprofile == "false")
   {
     _showVerifyProfileDialog();
    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ProfilePage(tok: widget.usertok.toString(),)), (Route<dynamic> route) => false); 
   }
   
 }
 // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage(usertok: hj,)), (Route<dynamic> route) => false);
}
 void _showVerifyProfileDialog() {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       // return object of type Dialog
       return AlertDialog(
         title: new Text("Profile Details"),
         content: new Text("Please fill your profile details"),
         actions: <Widget>[
          //  new FlatButton(
          //    child: new Text("Resent link"),
          //    onPressed: () {
          //      Navigator.of(context).pop();
              
          //    },
          //  ),
           new FlatButton(
             child: new Text("Verify Profile"),
             onPressed: () {
             
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => ProfilePage(tok: widget.usertok.toString(),)), (Route<dynamic> route) => false);
             },
           ),
           
         ],
       );
     },
   );
 }

 Future<void> getcurrentuser() async {
  hj =sharedPreferences.getString("token");
  kj = sharedPreferences.getString("user");
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage(usertok: hj,)), (Route<dynamic> route) => false);
}
  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
    else
   hj= sharedPreferences.getString("token");
  

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30,),
          Icon(Icons.chat_bubble, size: 30),
          Icon(Icons.person, size: 30),

        ],

        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),

        onTap: (index) {
          
            _page = index;
         
          switch(_page){
            case 0:
              {
                print("1st");
              }
              break;
            case 1:
              {
               print("2nd");
               
               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChatbotPage()));
              }
              break;
            case 2:
              {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ViewProfilePage(usertoker: widget.usertok,)));
              }
              break;


          }
        
       },
      ),
      appBar: AppBar(
        title: Text("CarrerConnect", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
             print(sharedPreferences.getString("token"));
           
               sharedPreferences.clear();
              //widget.logoutCallback();
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FadeAnimation(0.0,LoginPage())), (Route<dynamic> route) => false);
         
             
             // authStatus = AuthStatus.NOT_DETERMINED;
             
        // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),

          ),
        ],
      ),
      body:
      Center(
              child:RefreshIndicator(
                 onRefresh: getcurrentuser,

                child: new FutureBuilder(
                 future: getcurrentuser(),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                   switch(snapshot.connectionState){
                     case ConnectionState.none:
                       return Text("Press Button to Start !");
                     case ConnectionState.active:
                     case ConnectionState.waiting:
                       return Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(85, 75, 85, 8),));
                     case ConnectionState.done:

                     return   FadeAnimation(1.3, 
                     Main1Page(usertoken:"${widget.usertok}",domainchosen: widget.subdom,),);
                   }
                   return Text("hellofhgfhkhv",textScaleFactor: 50.0,);
                   //Container(height:10.0,width:20.0);
                 },
               ),
             ),
             ),
      //Center(child: Main1Page(usertoken:"${widget.usertok}",domainchosen: widget.subdom,),),

      drawer: 
   
       Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("User"),
              decoration:  BoxDecoration(
                       image: DecorationImage(
                        image: AssetImage("assets/flat1.gif"),
                       fit: BoxFit.contain,
                       ),
              ),

             // accountEmail: new Text('1234@gmail.com'),
              
              
              // decoration: new BoxDecoration(
              //   image: new DecorationImage(
              //     fit: BoxFit.fill,
              //    image: AssetImage("assets/profile10.png"),
              //   )
              // ),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Made By Technocrats"),
              //trailing: new Icon(Icons.),
              // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              //   builder: (BuildContext context) => //ProfilePage(),
              //  ProfilePage(subdomain: widget.subdom,tok: "${widget.usertok}",),
              // )),
            ),
            // new ListTile(
            //   title: new Text("Profile"),
            //   trailing: new Icon(Icons.person),
            //   onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            //     builder: (BuildContext context) => //ProfilePage(),
            //    ProfilePage(subdomain: widget.subdom,tok: "${widget.usertok}",),
            //   )),
            // ),
            // new Divider(),
            // new ListTile(
            //   title: new Text("Job Recommendation Quiz " ),
            //   trailing: new Icon(Icons.question_answer),
            //   subtitle: Text("20 mins"),

            //   onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            //     builder: (BuildContext context) => QuizStartPage(),// HomePage(usertokvar: "${widget.usertok}",),
            //   )),
            // ),
            // new Divider(),
            // new ListTile(
            //   title: new Text("FAQ \n Under Progress"),
            //   trailing: new Icon(Icons.reorder),
            //   // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            //   //   builder: (BuildContext context) => ItemReviewsPage(),
            //   // )),
            // ),
            //  new Divider(),
            // new ListTile(
            //   title: new Text("Feedback(IN PROGRESS)"),
            //   trailing: new Icon(Icons.rate_review),
            //   // onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            //   //   builder: (BuildContext context) => ItemReviewsPage(),
            //   // )),
            // ),
           
            

          ],
        ),
   
    ),
    );
  }
}