import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/jobs/general_jobs_model.dart';
import 'package:flutter_app/view/jobproposal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';



class SearchPage extends StatefulWidget {
 SearchPage({Key key, this.title,this.usertok}) : super(key: key);
final String title;
final String usertok;

  @override
  _SearchPageState createState() => new _SearchPageState();
}
class Debouncer {
  final int milliseconds;
  VoidCallback action;

  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _SearchPageState extends State<SearchPage> {
  final _debouncer = Debouncer(milliseconds: 100);
  List<Data> filteredUsers = List();
  TextEditingController editingController = TextEditingController();
  generalJobs genJobs;
  List<Data> data;
  var str = " ";


  Future<void> fetchJobs() async {
    final response = await http.get(
      'http://harshraj.pythonanywhere.com/organization/list-of-job',
      headers: {HttpHeaders.authorizationHeader: "token ${widget.title}"}, //4c136b7dbd75a637a1248db3be44c20a5a20a9ee
    );
    var responseJson = json.decode(response.body);
    print(responseJson);

    genJobs = generalJobs.fromJson(responseJson);
    data = genJobs.data;

  }

//  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//  var items = List<String>();
//


  Widget filterSearchResults(String query) {
    int count = 0;
    for(int i=0;i<=data.length;i++)
      {
        if(data[i].name == query)
          {
            return questionsList();
          }
      }
        setState(() {
          data.clear();
        });
  }
  @override
  void initState() {
    // TODO: implement initState

    
   
    super.initState();
   //filterSearchResults(" ");

  }
  

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Search",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,


      ),
      body:
       Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:
               TextField(
                onChanged: (str) {
                  _debouncer.run(() {
                    setState(() {
                      filteredUsers = data
                          .where((u) => (u.name
                          .toLowerCase()
                          .contains(str.toLowerCase()) ||
                          u.preferedCity .toLowerCase()
                          .contains(str.toLowerCase()) ||
                          u.jobTitle.toLowerCase().contains(str.toLowerCase())))
                          .toList();
                    });
                  });
                 //filterSearchResults(value);
                 // print("SESAFJBBHASFJ");
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search : For eg Google / Desired Work Location ",
                    hintText: "Search Company / Location",
                    focusColor: Colors.blue[100],
                   // prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.search),enabled: true,

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
             child: 
              RefreshIndicator(
               onRefresh: fetchJobs,
               child:
               new FutureBuilder(
                 future: fetchJobs(),
                 builder: (BuildContext context, AsyncSnapshot snapshot){
                   switch(snapshot.connectionState){
                     case ConnectionState.none:
                       return Text("Press Button to Start !");
                     case ConnectionState.active:
                     case ConnectionState.waiting:
                       return Center(child: CircularProgressIndicator(backgroundColor: Color.fromARGB(85, 75, 85, 8),));
                     case ConnectionState.done:

                     return questionsList();
                   }
                   return Text("hellofhgfhkhv",textScaleFactor: 50.0,);
                   //Container(height:10.0,width:20.0);
                 },
               ),
             ),

            ),
          ],
        ),
      ),
    );
  }

  ListView questionsList(){
    return ListView.builder(
      itemCount: filteredUsers.length,
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
                new Text(filteredUsers[i].jobTitle,style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                //new Text(questionList[i].question[i].answerText),

                FittedBox(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${filteredUsers[i].name}"),
                        //label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("${filteredUsers[i].preferedCity}"),
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

            children: <Widget>[
              JobDetail(data[i].jobDescreption, data[i].minimumExperience, data[i].id,widget.title),
//              AnswerWidget(questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain),
//              AnswerWidget(questionList[i].question,questionList[i].question[1].answerText,questionList[i].question[1].weightage,1,questionList[i].question[1].fromDomain),
              // AnswerWidget(questionList[i].question,questionList[i].question[2].answerText,questionList[i].question[2].weightage,2,questionList[i].question[1].fromDomain),

            ],

          ),
        ),
      ),
    );
  }
}




class JobDetail extends StatefulWidget {


  Data data;
  // final List<Question> question;

  final  String jobdescription;
  final int minimum_exp;
  final int id;
  final String usertok;
  //final int domain;


  //final int id;

  JobDetail(this.jobdescription,this.minimum_exp,this.id,this.usertok);

  @override
  _JobDetailState createState() => _JobDetailState();
}
//
class _JobDetailState extends State<JobDetail> {

  Color c = Colors.black;



  @override
  Widget build(BuildContext context) {

    return
      ListTile(
        onTap: (){

          setState(() {


//            if(widget.question[widget.index].fromDomain == 2)
//            {
//              list.add(widget.question[widget.index].weightage);
//              print(list);
//              print("list");
//              print(list.length);
//
//
//            }
//            else if(widget.question[widget.index].fromDomain == 1)
//            {
//              list1.add(widget.question[widget.index].weightage);
//              print(list1);
//              print("list1");
//              print(list.length);
//
//            }

            // if(widget.weightage <= 4)
            // {
            //    c = Colors.green[100];
            //   print("${widget.question[widget.index].weightage}");

            // }



          }
          );
        },



        title:
        new Text(
          widget.jobdescription,
          textAlign: TextAlign.start,
          style: new TextStyle(
            color: c,
            fontWeight: FontWeight.bold,
          ),

        ),
        trailing: new Text("Minimum Exp:${widget.minimum_exp}"),
        subtitle:  RaisedButton(

          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => JobProposal(token: widget.usertok,id: widget.id.toString(),)));
          },
          textColor: Colors.white,
          padding:  EdgeInsets.all(0.0),
          child: Container(

            decoration: const BoxDecoration(
              color: Colors.deepPurple,



              // gradient: LinearGradient(
              //   colors: <Color>[
              //   Color.fromARGB(0,0,255,0),
              //   Color.fromARGB(255,255,255, 255),
              //     // Color(0xFF0D47A1),
              //     // Color(0xFF1976D2),
              //     // Color(0xFF42A5F5),
              //   ],
              // ),

            ),
            padding: const EdgeInsets.all(5.0),
            child: const Text(
                'Apply Now',
                style: TextStyle(fontSize: 20)
            ),
          ),
        ),

      );

  }
}

