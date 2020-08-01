//import 'dart:html';

import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/view/viewprofilemodel.dart';

class ViewProfilePage extends StatefulWidget {
   ViewProfilePage({Key key, this.title,this.usertoker}) : super(key: key);
final String title;
final String usertoker;
  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  profilemodel pmv;
   List<Data> datar;
   var _data = new List();
   var _data1 = new List();
  bool _isLoading = false;
  var i;
  var responseJson;

   Future<void> fetchJobs() async {
    final response = await http.get(
      'http://harshraj.pythonanywhere.com/candidate/create/',
      headers: {HttpHeaders.authorizationHeader: "token ${widget.usertoker}"}, //4c136b7dbd75a637a1248db3be44c20a5a20a9ee
    );
   

     responseJson = json.decode(response.body);
     print(responseJson);

     print(responseJson['data']['Name']);
    // _data.addAll((responseJson['data']['Skills'])

    _data = responseJson['data']['Skills'];

   // print(_data.forEach((element) {print(element);}));
    _data.forEach((element) { _data1.add(element['Name']); });
    print(_data1);
   
    
   
    
    // print(pmv.data);
  
    

  }

  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.deepPurple[300],
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
 

  Widget _getInfo(String a,b,c) {
    return Positioned(
      top: 50,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.width * 0.90,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("User information:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: Container(
                        decoration: BoxDecoration(
                       image: DecorationImage(
                        image: AssetImage("assets/user.png"),
                       fit: BoxFit.contain,
                       ),
                       ),
                        ), 
                      ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text("Name: $a"),
                         SizedBox(
                         height: 20,
                         ),
                          Text("Address: $b"),
                    ],
                  ),
                  
                 
      
                ],
              ),
             

              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(
                  //   width:MediaQuery.of(context).size.width * 0.90,
                  //   child: Text("Resume $c"),
                  // ),
                  Container (
                   padding: const EdgeInsets.all(16.0),
                  width: MediaQuery.of(context).size.width*0.8,
                  child: new Column (
                 children: <Widget>[
                  new Text ("Resume: $c", textAlign: TextAlign.left),
         
        ],
      ),
    ),
                  //Text("Resume $c"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _userSkills(String a,b,List<dynamic> c) {
    return Positioned(
      top: 340,
      child: Container(
        margin: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.width * 0.90,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20),),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "User Profile :",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Row( crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   FilterChip(
                        backgroundColor: Colors.grey[300],
                        padding: EdgeInsets.all(10.0),
                         shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                       elevation: 10.0,

                        label: Text("MarketRating: $a")
                       
                       
                      ),
                       SizedBox(
                       width: 20,
                      ),
                       FilterChip(
                        backgroundColor: Colors.grey[300],
                        padding: EdgeInsets.all(10.0),
                         shadowColor: Colors.blue,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                         elevation: 10.0,

                        label: Text("TechRating: $b"),
                      
                       ),
                       ],
                       ),
                      SizedBox(
                      height: 20,
                       ),
                      Text(
                     "Resume Skills Analysis:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                   ),
                   Expanded(
                     child: Row(
                     children: <Widget>[
                          Container(
                     constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80,
                    maxHeight: MediaQuery.of(context).size.width * 0.80,

                    ),

                     child:skillList(c),

                       
                   
                   ),
                  


                     ],
                   ),

                
                  
                   ),
                  // skillList(c),

                  //  Row(children: <Widget>[
                  //     Wrap(
                    
                  //    children: <Widget>[
                  //      skillList(c)
                  //    ],
                  //  ),
                  //  ],)
                  
              // Row(
              
               
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text("Village:"),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text("Nongnioa village"),
              //   ],

              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text("District:"),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text("Sikhottabong district"),
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Text("Province:"),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Text("Vietiane capital"),
             //   ],
            //  ),
            ],
          ),
        ),
      ),
    );
  }
 ListView skillList(List<dynamic> a){
  
    return ListView.builder(
      shrinkWrap: true,
      itemCount: a.length,
      addAutomaticKeepAlives: true,

       scrollDirection: Axis.horizontal,
      


      itemBuilder: (context,i,)=>FilterChip(


       
        shadowColor: Colors.blue,
       // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        labelPadding: EdgeInsets.all(11.0),
        elevation: 10.0,
        label: Text("${a[i].toString()}"),
      ),

    );

  }




  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[IconButton(icon: Icon(Icons.person, color: Colors.black),onPressed: (){},),],
      ),
      body: SingleChildScrollView(
        
        child: _isLoading
            ? Center(child: LinearProgressIndicator())
            : new FutureBuilder(
          future: fetchJobs(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return Text("Press Button to Start !");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(85, 75, 85, 8),));
              case ConnectionState.done:
                return Stack(
                   children: <Widget>[
                  Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  ),
                  //Text("${d}")
                 _greenColors(),
                 _getInfo(responseJson['data']['Name'], responseJson['data']['Address'], responseJson['data']['Resume']),
                 _userSkills(responseJson['data']['MarketRating'].toString(), responseJson['data']['TechRating'].toString(),_data1),
               //  _buildBottomCard(width, height)
                 
              //  Text("${snapshot.data}"),
                 ],
                );
                
                //Row(child: questionsList());
                
                
            }
            return null;
            
          },
        ),
        // Stack(
        //   children: <Widget>[
        //     Container(
        //       height: MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //     ),
        //     _greenColors(),
        //     _getInfo(),
        //     _userAdress(),
        //   ],
        // ),
      ),
    );
  }
}


  ListView skillList(List<dynamic> a){
  
    return ListView.builder(
      shrinkWrap: true,
      itemCount: a.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context,i,)=>FilterChip(

       
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 10.0,
        label: a[i],
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
 
      ),

    );

  }
