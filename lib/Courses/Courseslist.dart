import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_app/jobs/general_jobs_model.dart';
import 'package:flutter_app/view/jobproposal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import './Blogs_model.dart';



class SearchCoursesPage extends StatefulWidget {
 SearchCoursesPage({Key key, this.title,this.usertok}) : super(key: key);
final String title;
final String usertok;

  @override
  _SearchCoursesPageState createState() => new _SearchCoursesPageState();
}


class _SearchCoursesPageState extends State<SearchCoursesPage> {
 
  Blogs _blogs;
  List<Data> _data;
  var data1 = new List();
  var data2 = new List();
  var responseJson;
  var test;

  Future<void> fetchJobs() async {
    final response = await http.get(
      'http://harshraj.pythonanywhere.com/content/Recommended-courses/',
      headers: {HttpHeaders.authorizationHeader: "token ${widget.usertok}"}, //4c136b7dbd75a637a1248db3be44c20a5a20a9ee
    );
     responseJson = json.decode(response.body);

    // print(responseJson);
    //  _blogs = Blogs.fromJson(responseJson['Blogs_list']);
   //  print( _blogs);
     
     data1 = responseJson['Course_list']['data'] ;
     print(data1);
    print(data1.length);
    print(responseJson['Blogs_list']['count']);
     // data1.forEach((element) { data2.add(element); });

    
    // data2.asMap().containsKey('Title');

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
      // appBar: new AppBar(
      //   title: Text("Search",style: TextStyle(color: Colors.white),),
      //   backgroundColor: Colors.deepPurple,


      // ),
      body: 
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

            
          
     
     
    );
  }
 
  ListView questionsList(){
    return ListView.builder(
      itemCount:data1.length,
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
               new Text(data1[i]['Title'].toString(),style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                //new Text(questionList[i].question[i].answerText),
              
              
                FittedBox(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text("Rating: ${data1[i]['Rating'].toString()} ",),
                        //label: Text("vhgfhvvhvv"),
                        onSelected: (b){},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(" ${data1[i]['Refrences'].toString()}",style: TextStyle(fontSize: 18.0),),
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
              child: new Text("Courses"
                //questionList[i].domain.toString(),
                // .startsWith("1")?"M":"B"
              ),
            ),

            children: <Widget>[
           BlogDetail(data1[i]['photo'],data1[i]['Apply']),
//              AnswerWidget(questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain),
//              AnswerWidget(questionList[i].question,questionList[i].question[1].answerText,questionList[i].question[1].weightage,1,questionList[i].question[1].fromDomain),
              // AnswerWidget(questionList[i].question,questionList[i].question[2].answerText,questionList[i].question[2].weightage,2,questionList[i].question[1].fromDomain),

            ],

          ),
        ),
      )
    );
   
  }
}




class BlogDetail extends StatefulWidget {


  Data data;
  // final List<Question> question;

  final String pic;
  final String apply;

  //final int domain;


  //final int id;

  BlogDetail(this.pic,this.apply);

  @override
  _BlogDetailState createState() => _BlogDetailState();
}
//
class _BlogDetailState extends State<BlogDetail> {

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
        new Image.network(
        widget.pic,
          ),

      
        subtitle:  RaisedButton(

          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => null));
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

