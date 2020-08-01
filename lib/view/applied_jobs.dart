import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
//import 'package:flutter_app/jobs/general_jobs_model.dart';
import 'package:flutter_app/jobs/appliedjobs_model.dart';
import './jobproposal.dart';

class AppliedPage extends StatefulWidget {
  AppliedPage({Key key, this.tok,}) : super(key: key);
  final String tok;



  @override
  _AppliedPageState createState() => new _AppliedPageState();
}
class _AppliedPageState extends State<AppliedPage> {
  //generalJobs genJobs;
  List<Data> _data;
  Apply appjob;

  @override
  void initState() {
    updaterecommjobs();
    super.initState();
  }
  Future<void> updaterecommjobs() async
  {


//    Map data = {
//      'first': "${widget.first}",
//      'Second': "${widget.second}",
//      'third':"${widget.third}",
//      'fourth':"${widget.fourth}",
//    };
    var jsonResponse = null;
    var response = await http.get("http://harshraj.pythonanywhere.com/candidate/get-application/",headers: {HttpHeaders.authorizationHeader:"token ${widget.tok}"});
    //  if(response.statusCode == 200)
    //  {
    //    jsonResponse = json.decode(response.body);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    //  }
    //  else
    //  print("Error");
    var responseJson = json.decode(response.body);
    print(responseJson);

    appjob = Apply.fromJson(responseJson);
    _data = appjob.data;

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Applied Jobs List"),

        elevation: 0.0,
      ),
      body:
      RefreshIndicator(
        onRefresh: updaterecommjobs,
        child:
        new FutureBuilder(
          future: updaterecommjobs(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
                return Text("Press Button to Start !");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(85, 75, 85, 8),));
              case ConnectionState.done:
                if(snapshot.hasError) return errorData(
                    snapshot
                );
                return
                  // Container(height:10.0,width:20.0);
                  questionsList();

            }
            return Text("hellofhgfhkhv",textScaleFactor: 50.0,);
            //Container(height:10.0,width:20.0);
          },
        ),
      ),
      extendBodyBehindAppBar: true,

    );
  }


  Padding errorData(AsyncSnapshot snapshot){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AlertDialog(title: Text("Your Internet Connection is poor")),
          new Text("Error :${snapshot.error}"),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: (){
              updaterecommjobs();
              setState(() {

              });
            },
            child: new Text("Try Again"),
          )
        ],
      ),
    );
  }
  ListView questionsList(){
    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context,i,)=>Card(
        color: Colors.white,
        shadowColor: Colors.blue[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[
                //SearchInput(),
                // if(questionList[i].domain == 2)
                // {
                //       new Text(questionList[i].questionText,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                // },

                new Text(_data[i].jobName,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                //new Text(questionList[i].question[i].answerText),

                FittedBox(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${_data[i].jobCompany}"),
                        //label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${_data[i].at}"),
                        // label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      )

                    ],
                  ),
                )
              ],
            ),
            leading: new CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: new Text("J"
                //questionList[i].domain.toString(),
                // .startsWith("1")?"M":"B"
              ),
            ),

//            children: <Widget>[
//              //JobDetail(_data[i].jobDescreption, _data[i].minimumExperience, _data[i].id,widget.tok),
//
//            ],

          ),
        ),
      ),
    );
  }



}
//class JobDetail extends StatefulWidget {
//
//
//  Data data;
//  // final List<Question> question;
//
//  final  String jobdescription;
//  final int minimum_exp;
//  final int id;
//  final String usertok;
//  //final int domain;
//
//
//  //final int id;
//
//  JobDetail(this.jobdescription,this.minimum_exp,this.id,this.usertok);
//
//  @override
//  _JobDetailState createState() => _JobDetailState();
//}
////
//class _JobDetailState extends State<JobDetail> {
//
//  Color c = Colors.black;
//
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    return
//      ListTile(
//        onTap: (){
//
//          setState(() {
//
//          }
//          );
//        },
//
//
//
//        title:
//        new Text(
//          widget.jobdescription,
//          textAlign: TextAlign.start,
//          style: new TextStyle(
//            color: c,
//            fontWeight: FontWeight.bold,
//          ),
//
//        ),
//        trailing: new Text("Minimum Exp:${widget.minimum_exp}"),
//        subtitle:  RaisedButton(
//
//          onPressed: () {
//            Navigator.of(context).push(MaterialPageRoute(builder: (_) => JobProposal(token: widget.usertok,id: widget.id.toString(),)));
//            // print("Apply Now");
//          },
//          textColor: Colors.white,
//          padding:  EdgeInsets.all(0.0),
//          child: Container(
//
//            decoration: const BoxDecoration(
//              color:Colors.deepPurple,
////            gradient: LinearGradient(
////            colors: <Color>[
////            Color(0xFF0D47A1),
////            Color(0xFF1976D2),
////            Color(0xFF42A5F5),
////        ],
////      ),
//
//            ),
//            padding: const EdgeInsets.all(5.0),
//            child: const Text(
//                'Apply Now',
//                style: TextStyle(fontSize: 20)
//            ),
//          ),
//        ),
//
//      );
//
//  }
//}

