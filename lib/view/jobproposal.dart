import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/questions/general_question.dart';
import 'package:flutter_app/main.dart';
import 'dart:async';
 import 'dart:convert';
 import 'package:http/http.dart' as http;
class JobProposal extends StatefulWidget {
  JobProposal({Key key,this.token,this.id}) : super(key: key);  
final String token;
final String id;

  @override
  _JobProposalState createState() => _JobProposalState();
}

class _JobProposalState extends State<JobProposal> {
  //final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();

Future<void> applyjob(String a) async
  {
  
      
      
       Map data = {
      'proposal': a,
     
       };
       var jsonResponse = null;
       var response = await http.post("http://harshraj.pythonanywhere.com/candidate/apply/${widget.id}/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.token}"});
       if(response.statusCode == 200)
       {
         jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
     


       }
       else
        print("error");
  }
 

  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   void _showDialog(String msg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ALERT"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

        

          TextField(
          controller: _controller,
          decoration: InputDecoration(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
            hintText: "Write Job Proposal",
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintStyle: TextStyle(color: Colors.black),
            
          ),
         
          onSubmitted: (String value) async {
            await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Do you want to Apply'),
                  
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                       Navigator.pop(context);
                        Navigator.pop(context);

                      },
                      child: const Text('Dismiss'),
                    ),
                    FlatButton(
                      onPressed: () {
                          applyjob("${value}");
                        Navigator.pop(context);
                         Navigator.pop(context);
                      },
                      child: const Text('Submit'),
                    ),
                   
                  ],
                );
              },
            );
          },
        ),
        
        
        ]
      ),
      ),
    );
  }
}
