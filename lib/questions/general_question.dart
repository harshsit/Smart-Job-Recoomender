import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/questions/domain_specific.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
//import 'package:flutter_app/results/genresult.dart';
//import 'package:flutter_app/results/UserResult.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.usertokvar}) : super(key: key);
final String usertokvar;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var x;
   bool _isLoading = false;
  var mark1 = new List();
  var mark2 = new List();
  var overallgentotal = new List();
  var checkquestansid = new List();
  int j;
  
  
 
 
  int total1;
  General quiz;
  List<QuestionList> questionList;
  List<Question> question;
  
Timer _timer;
int _start = 600;

void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      },
    ),
  );
}

recordmarks(String domaininfo, b, questionid)
{

 
   if(overallgentotal.contains(questionid))
   {  
     
     j= overallgentotal.indexOf(questionid);
     
       if(domaininfo == "1" )
                 {
                  mark1.removeAt(j);      
                   mark1.toList();
                   mark1.insert(j, "${b}");
                   print(mark1);
                   print("lIST 1");
                 

                 }
                 else if(domaininfo == "2" )
                 {
                  mark2.removeAt(j);
                   print(mark2);
                   mark2.insert(j, "${b}");
                   print(mark2);
                   print("LIST 2");
                 }
                 print(overallgentotal);
       
   }
   else
     { 
       overallgentotal.add("${questionid}");
       print(overallgentotal);
         if(domaininfo == "1" )
                 {
                   mark1.add("${b}");
                   mark1.toList();

                   print(mark1);
                   print("lIST 1");

                 }
                 else if(domaininfo == "2" )
                 {
                   mark2.add("${b}");
                   print(mark2);
                   print("LIST 2");
                 }
     }
             
 
}

  Future<void> updategenmarks(int a,b) async
  {
    int c = a + b;
    String domain1 = a.toString();
    String domain2 = b.toString();
    String total = c.toString();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'Technology': domain1,
      'Marketing': domain2,
      'Total':total,
    };
    var jsonResponse = null;
    var response = await http.post("http://harshraj.pythonanywhere.com/candidate/put-general-marks/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.usertokvar}"});
    if(response.statusCode == 200)
    { 
      jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      jsonResponse.toString();
      //jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    else
      print("Error");

  }


  Future<void> fetchQuestions()async{
    var res = await http.get("https://harshraj.pythonanywhere.com/user/api/get-question/?format=json");
    var decRes = jsonDecode(utf8.decode(res.bodyBytes));

    //var _decRes = res.body.toString().codeUnitAt(decRes);
   // print(_decRes);
   // print(decRes);
    //_decRes = decRes.toString().codeUnitAt(decRes);
    quiz = General.fromJson(decRes);
    questionList = quiz.questionList;  
  }

 int getArraySum(List<dynamic> a,List<dynamic> b){
    int i = 0;
    int j;
    var c = List<int>(b.length);
    var d =  List<int>(a.length);
    int total1 = 0;
    int total2 = 0;
    String max;
    for(j = 0; j <= (a.length-1); j++)
    {
      d[j] = int.parse(a[j]);
    }
    for(j= 0; j <= (b.length -1); j++)
    {
      c[j] = int.parse(b[j]);
    }
 
  for(i = 0; i <= (d.length - 1); i++)
  {
    total1 += d[i];
  }
  print(total1);
   for(i = 0; i <= (c.length - 1); i++)
  {
    total2 += c[i];
  }
print("Tech: $total1");
print("Marketting: $total2");


  if(total1 > total2)
  {
    max = 1.toString();
  }
  else
  {
    max = 2.toString();

  }
    updategenmarks(total1,total2);
   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => HomePage1(maxdomain: max,token: widget.usertokvar,roundeoneT: total1.toString(),roundeoneM: total2.toString(),)),
     //  ResPage(resmarks1: total1,resmarks2:total2,round: "2nd",previousround: "1st",maximum: max,token: widget.tokenvariable,),),
                   );

}
 
 answerslist(List<List<String>> c){

 var d = c;
 d.toString();

 return d;

  
 }

 @override
  void initState() {
    // TODO: implement initState
   
   
   
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea (child:Scaffold(
      appBar: new AppBar(
        title: new Text("Quiz",style: TextStyle(color: Colors.white),),
         actions: <Widget>[
         
          FlatButton(
            onPressed: () {
              getArraySum(mark1, mark2);
            },
            child: Text("Submit", style: TextStyle(color: Colors.white)),

          ),
        ],
      
     
        backgroundColor: Colors.deepPurple,
        
        elevation: 0.0,
      ),
      body: 
      RefreshIndicator(
        onRefresh: fetchQuestions,
        child: 
        new FutureBuilder(
          future: fetchQuestions(),
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
                questionsList();
                //Row(child: questionsList());
                
                
            }
            return null;
            
          },
        ),
      ),
    )
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
              fetchQuestions();
              setState(() {

              });
            },
            child: new Text("Try Again"),
          )
        ],
      ),
    );
  }

   Container sbuttonSection() {
   return Container(
     width: MediaQuery.of(context).size.width,
     height: 40.0,
     padding: EdgeInsets.symmetric(horizontal: 15.0),
     margin: EdgeInsets.only(top: 15.0),
     child: RaisedButton(
       onPressed: () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => null),
         );
       },
       elevation: 0.0,
       color: Colors.greenAccent,
       child: Text("Submit", style: TextStyle(color: Colors.white70)),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
     ),
   );
 }

 


  ListView questionsList(){
  
    return ListView.builder(
      itemCount: questionList.length == null ? 0 :  questionList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context,i,)=>Card(
        semanticContainer: true,
        margin: EdgeInsets.all(2.0),
        color: Colors.white,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 10.0,
       
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               
               new Text(questionList[i].questionText,style: new TextStyle(fontSize: 18.0,),),
                
            
                RadioButtonGroup(
                  orientation: GroupedButtonsOrientation.VERTICAL,


                   labels:questionList[i].question.map((child) =>  child.answerText).toList(),
                   onChange: (label, index) {
                    //  print(label);
                    //  print(index);
                    //  print(questionList[i].question[index].fromDomain);

                    recordmarks(questionList[i].question[index].fromDomain.toString(),questionList[i].question[index].weightage,questionList[i].id);
                   },

                   //onChange: (label, index) => print(labe)//recordmarks("${questionList[i].question[index].fromDomain}","${questionList[i].question[index].weightage}","${questionList[i].id}"),
                   margin: EdgeInsets.all(2.0),

                  // print("${questionList[i].question[index].weightage} : ${questionList[i].id}"),
                   //onSelected: (String selected) =>  AnswerWidget(questionList.length,questionList,questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain,mark1,mark2,checkquestansid,total1,widget.usertokvar,overallgentotal)
                   ),


             ],
           ),
           
           )
       
     

    );
    

  }

}




  
 
  