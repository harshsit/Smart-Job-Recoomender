import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app/questions/question_level3_domain_model.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/results/finalresult.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class LevelPage extends StatefulWidget {
   LevelPage({Key key, this.tok,this.level3_1,this.level3_2,this.level2max,this.level2secondmax}) : super(key: key);
final String tok;
final String level3_1;
final String level3_2;
final String level2max;
final String level2secondmax;


  
  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
   var mark1 = new List();
  var mark2 = new List();
  var globalmarks = new List();
  int j;
 
  Level _level;
  List<Data> data;
  
  List<QuestionDomain> questionDomain;
  

  Future<void> fetchQuestions()async{
    var res = await http.get("http://harshraj.pythonanywhere.com/user/level3/${widget.level3_1}/${widget.level3_2}/");
    var decRes = jsonDecode(utf8.decode(res.bodyBytes));
    print(decRes);
    _level = Level.fromJson(decRes);
    data = _level.data;
   
    
  }
  int getArraySum(List<dynamic> a,List<dynamic> b,List<dynamic> x){
    int i = 0;
    int j;
    
    var subdomaintotal = new List<int>();
   
   var e = x.length;
   var totalquizes = 20;
    var c = List<int>(b.length);
    var d =  List<int>(a.length);
    
    int total1 = 0;
    int total2 = 0;
    
    int finaltotal = 0;
    int threshold ;
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
  subdomaintotal.add(total1);
   for(i = 0; i <= (c.length - 1); i++)
  {
    total2 += c[i];
  }
  print(total2);
  subdomaintotal.add(total2);
  

  print(subdomaintotal);
   subdomaintotal.sort();
   print(subdomaintotal);
   print(subdomaintotal.first);
   print(subdomaintotal.last);
     for(i = 0; i <= (subdomaintotal.length - 1); i++)
  {                                                                     
    finaltotal += subdomaintotal[i];
  }
 double rating = ((finaltotal/totalquizes) * 5);

 print(finaltotal);
                                                                      // LOGIC IS WRONG HAVE TO CHANGE LATER
  
  if(total1 > total2)
  {
     Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResDomPage(resmarks1: total1,previousround: "3rd",maximum: 1.toString(),token: widget.tok, ),),
                   );
  }
  else{
    Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => ResDomPage(resmarks1: total2,previousround: "3rd",maximum: 2.toString(),token:widget.tok),),
                   );

  }
  
  }

recordmarks(String domaininfo, b, questionid)
{

 
   if(globalmarks.contains(questionid))
   {  
     
     j= globalmarks.indexOf(questionid);
     
       if(domaininfo == widget.level3_1 )
                 {
                  mark1.removeAt(j);      
                   mark1.toList();
                   mark1.insert(j, "${b}");
                   print(mark1);
                   print("lIST 1");
                 

                 }
                 else if(domaininfo == widget.level3_2 )
                 {
                  mark2.removeAt(j);
                   print(mark2);
                   mark2.insert(j, "${b}");
                   print(mark2);
                   print("LIST 2");
                 }
                 print(globalmarks);
       
   }
   else
     { 
       globalmarks.add("${questionid}");
       print(globalmarks);
         if(domaininfo == widget.level3_1 )
                 {
                   mark1.add("${b}");
                   mark1.toList();

                   print(mark1);
                   print("lIST 1");

                 }
                 else if(domaininfo == widget.level3_2 )
                 {
                   mark2.add("${b}");
                   print(mark2);
                   print("LIST 2");
                 }
     }
             
 
}
 
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("3rd Round"),
        actions: <Widget>[
         
          FlatButton(
            onPressed: () {
              getArraySum(mark1, mark2, globalmarks);
            },
            child: Text("Submit", style: TextStyle(color: Colors.white)),

          ),
        ],
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh: fetchQuestions,
        child: new FutureBuilder(
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
                // Container(height:10.0,width:20.0);
                questionsList();

            }
            return null;
          },
        ),
      ),
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
 Container Submit(){
   Text("SUBMIT");
 }


  ListView questionsList(){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,i,)=>Card(
        color: Colors.white,
        shadowColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        elevation: 10.0,
          child: Padding(
           padding: EdgeInsets.all(5.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Column(
                 children: <Widget>[
                   
                   new Text(data[i].questionText,style: new TextStyle(fontSize: 18.0,),),
                  
                   RadioButtonGroup(
                   labels:data[i].questionDomain.map((child) => child.answerText).toList(),
                   onChange: (label, index) =>  recordmarks("${data[i].questionDomain[index].fromDomain}","${data[i].questionDomain[index].weightage}","${data[i].id}")
                  // print("${questionList[i].question[index].weightage} : ${questionList[i].id}"),
                   //onSelected: (String selected) =>  AnswerWidget(questionList.length,questionList,questionList[i].question,questionList[i].question[0].answerText,questionList[i].question[0].weightage,0,questionList[i].question[0].fromDomain,mark1,mark2,checkquestansid,total1,widget.usertokvar,overallgentotal)
                   ),

                 ],
               ),
               
               // new Text(questionList[i].questionText,style: new TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold),),
             ],
           ),
           
           )
        
      ),
    );
  }
}



