import 'dart:ffi';
import 'dart:io';

import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter_app/questions/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/questions/question_level3_domain.dart';
//import 'package:flutter_app/results/domainresult.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:flutter_app/questions/domain_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage1 extends StatefulWidget {
   HomePage1({Key key, this.maxdomain,this.token,this.roundeoneT,this.roundeoneM  }) : super(key: key);
final String maxdomain;
final String token;
final String roundeoneT;
final String roundeoneM;


  
  @override
  _HomePageState1 createState() => _HomePageState1();
}

class _HomePageState1 extends State<HomePage1> {
  var mark1 = new List();
  var mark2 = new List();
  var mark3 = new List();
  var mark4 = new List();
  var globmarks = new List();
  int j;

  

  General quiz;
  Domainspec quiz1;
  
  List<Data> data;
  List<QuestionDomain> questionDomain;
  

  Future<void> fetchQuestions()async{
  
    var res = await http.get("http://harshraj.pythonanywhere.com/user/api/get-domain-question/?Domain=${widget.maxdomain}");
  
    var decRes = jsonDecode(utf8.decode(res.bodyBytes));
    print(decRes);
    quiz1 = Domainspec.fromJson(decRes);
    data = quiz1.data;
      
  }

   updatedommarks(String a, d) async
   {
  


     String total = a.toString();
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     Map data = {
       'Domain': d,
       'Total':total,
     };
     var jsonResponse = null;
     var response = await http.post("http://harshraj.pythonanywhere.com/candidate/put-domain-marks/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.token}"});
     if(response.statusCode == 200)
     {
       jsonResponse = json.decode(response.body);
       print('Response status: ${response.statusCode}');
       print('Response body: ${response.body}');
       print("level 2 marks are applied");
     }
     else
       print("Error");

   }
   
int getArraySum(List<dynamic> a,List<dynamic> b,List<dynamic> x, List<dynamic> y,String recdata){
    int i = 0;
    int j;
    int subdomainHighestmax,subdomainSecondhighestmax;
    var level3url1,level3url2;
  
    var subdomaintotal = new List<int>();

    var c = List<int>(b.length);       //Second List of Marks
    var d =  List<int>(a.length);      // First List of Marks
    var e = List<int>(x.length);       //Third list of marks
    var f = List<int>(y.length);       //Fourth List of marks
    int total1 = 0;
    int total2 = 0;
    int total3 = 0;
    int total4 = 0;
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
     for(j= 0; j <= (x.length -1); j++)
    {
      e[j] = int.parse(x[j]);
    }
     for(j= 0; j <= (y.length -1); j++)
    {
      f[j] = int.parse(y[j]);
    }


    
  for(i = 0; i <= (d.length - 1); i++)
  {
    total1 += d[i];
  }
  print("Second Domain: $total1");
  subdomaintotal.add(total1);
   for(i = 0; i <= (c.length - 1); i++)
  {
    total2 += c[i];
  }
  print("First Domain: $total2");
  subdomaintotal.add(total2);
   for(i = 0; i <= (e.length - 1); i++)
  {
    total3 += e[i];
  }
  print("Third Domain: $total3");
  subdomaintotal.add(total3);
   for(i = 0; i <= (f.length - 1); i++)
  {
    total4 += f[i];
  }
  print("Fourth Domain: $total4");
  subdomaintotal.add(total4);

  print(subdomaintotal);
   subdomaintotal.sort();
   print("List of SubdomainTotal : $subdomaintotal");

   print(subdomaintotal.first);
   print(subdomaintotal.last);
   subdomainHighestmax = subdomaintotal.last;
print("Length ${subdomaintotal.length}");
for(i=0;i<=(subdomaintotal.length - 1);i++)
{
  finaltotal += subdomaintotal[i];
  print(finaltotal);
}

print("finaltotal $finaltotal");
//  for(i = 0; i <= (subdomaintotal.length - 1); i++)
//   {
//     finaltotal += subdomaintotal[i];
//   }
subdomaintotal.remove(subdomainHighestmax);

subdomainSecondhighestmax = subdomaintotal.last;

print("subdomainHighestmax: $subdomainHighestmax");
print("subdomainSecondhighestmax: $subdomainSecondhighestmax");





if(recdata == '1')                            // SubdOMAIN 3/2/5/7
{
  if(subdomainHighestmax ==  total1)
  {
    level3url1 = 3;
    print(level3url1);
  }
  else if (subdomainHighestmax ==  total2)
  {
    level3url1 = 2;
     print(level3url1);

  }
  else if (subdomainHighestmax ==  total3)
  {
    level3url1 = 5;
     print(level3url1);
  }
  else if (subdomainHighestmax ==  total4)
  {
    level3url1 = 7;
     print(level3url1);
  }
  
if(subdomainSecondhighestmax ==  total1)
  {
  
    level3url2 = 3;
     print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total2)
  {
    level3url2 = 2;
     print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total3)
  {
    level3url2 = 5;
     print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total4)
  {
    level3url2 = 7;
     print(level3url2);
  }


}
else
{
   if(subdomainHighestmax ==  total1)
  {
    level3url1 = 10;
    print(level3url1);
    
  }
  else if (subdomainHighestmax ==  total2)
  {
    level3url1 = 9;
    print(level3url1);
  }
  else if (subdomainHighestmax ==  total3)
  {
    level3url1 = 11;
    print(level3url1);
  }
  else if (subdomainHighestmax ==  total4)
  {
    level3url1 = 13;
    print(level3url1);
  }
  
if(subdomainSecondhighestmax ==  total1)
  {
  
    level3url2 = 10;
     print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total2)
  {
    level3url2 = 9;
    print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total3)
  {
    level3url2 = 11;
    print(level3url2);
  }
  else if (subdomainSecondhighestmax ==  total4)
  {
    level3url2 = 13;
    print(level3url2);
  }

}

// print(subdomainHighestmax);
// print(subdomainSecondhighestmax);
// print("finaltotalmarks: $finaltotal");
// updatedommarks(subdomainHighestmax.toString(),level3url1.toString() );

 //print("finaltotalmarks: $finaltotal");
 //threshold = (20 * 0.70).floor();

 if(finaltotal > 1)
 {
    if(recdata == '1')

    {
       updatedommarks(subdomainHighestmax.toString(),recdata.toString() );
       Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => LevelPage(tok: widget.token,level3_1: level3url1.toString(),level3_2: level3url2.toString(),level2max: subdomainHighestmax.toString(),level2secondmax: subdomainSecondhighestmax.toString(),level1max: widget.roundeoneT,level1smax: widget.roundeoneM,)),
     //  ResDomPage(resmarks1: finaltotal,round: "3rd",previousround: "2nd",maximum: recdata,usertokenvar: widget.usertok,),),
                   );
    }
    else
    {
        updatedommarks(subdomainHighestmax.toString(),recdata.toString() );
        Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => LevelPage(tok: widget.token,level3_1: level3url1.toString(),level3_2: level3url2.toString(),)),
     //  ResDomPage(resmarks1: finaltotal,round: "3rd",previousround: "2nd",maximum: recdata,usertokenvar: widget.usertok,),),
                   );
    }
 
 }
 else
 {  
    if(recdata == '1')
    {
       Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 2.toString(),token: widget.token,)),
                   );
    }
     else{
        Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 1.toString(),token: widget.token)),
                   );
     }
 }
  

  
 }
recordmarks(String domaininfo, b, questionid)
{

 
   if(globmarks.contains(questionid))
   {  
     
     j = globmarks.indexOf(questionid);
     
              if(domaininfo == "2" ||  domaininfo == "9")
                 {
                  mark1.removeAt(j);      
                   mark1.toList();
                   mark1.insert(j, "${b}");
                   print(mark1);
                   print("lIST 1");
                 

                 }
                 else if(domaininfo == "3" || domaininfo == "10")
                 {
                  mark2.removeAt(j);
                   print(mark2);
                   mark2.insert(j, "${b}");
                   print(mark2);
                   print("LIST 2");
                 }
                 else if(domaininfo == "5" || domaininfo == "11")
                 {
                  mark3.removeAt(j);
                   print(mark3);
                   mark3.insert(j, "${b}");
                   print(mark3);
                   print("LIST 3");
                 }
                  else if(domaininfo == "7" || domaininfo == "13")
                 {
                  mark4.removeAt(j);
                   print(mark4);
                   mark4.insert(j, "${b}");
                   print(mark4);
                   print("LIST 4");
                 }

                 print(globmarks);
       
   }
   else
     { 
       globmarks.add("${questionid}");
       print(globmarks);
         if(domaininfo == "2" ||  domaininfo == "9" )
                 {
                   mark1.add("${b}");
                   mark1.toList();

                   print(mark1);
                   print("lIST 1");

                 }
                 else if(domaininfo == "3"  ||  domaininfo == "10")
                 {
                   mark2.add("${b}");
                   print(mark2);
                   print("LIST 2");
                 }
                  else if(domaininfo == "5"  ||  domaininfo == "11")
                 {
                   mark3.add("${b}");
                   print(mark3);
                   print("LIST 3");
                 }
                  else if(domaininfo == "7"  ||  domaininfo == "13")
                 {
                   mark4.add("${b}");
                   print(mark4);
                   print("LIST 4");
                 }

     }
             
 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("2nd Round of Quiz",style: TextStyle(color:Colors.white),),
         actions: <Widget>[
         
          FlatButton(
            onPressed: () {
             getArraySum(mark1, mark2, mark3, mark4, widget.maxdomain.toString());
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
                   labels: data[i].questionDomain.map((child) => child.answerText).toList(),
                   onChange: (label, index) => recordmarks(data[i].questionDomain[index].subDomain.toString(),data[i].questionDomain[index].weightage,data[i].id),
     
                   ),

                 ],
               ),
               
               
             ],
           ),
           
           )
     
      ),
    );
  }
}



// class AnswerWidget extends StatefulWidget {
  
 
//    QuestionDomain ansers1;

   
    
//     QuestionList questionList;
//     Data data;
//   final int ln;
//    final List<QuestionDomain> questionDomain;
  
//   final  String answerText;
//   final int weightage;
//   final int index;
//   final int domain;
//   final List mj;
//   final List dj;
//   final List aj;
//   final List bj;
//   final List glob;
//   final String domaindata;
//   final String usertok;

   
//   //final int id;
  
//  AnswerWidget(this.ln,this.questionDomain,this.answerText,this.weightage,this.index,this.domain,this.mj,this.dj,this.aj,this.bj,this.glob,this.domaindata,this.usertok);

//   @override
//   _AnswerWidgetState createState() => _AnswerWidgetState();
// }

// class _AnswerWidgetState extends State<AnswerWidget> {
   
//    Color c = Colors.black;
//   int count = 0;
//   int count1 = 0;
//   List total ;
//   bool tapped = false;
//   var marklist = List();
//    Future<void> updatedommarks(int a,String d) async
//    {
//      int c = a;


//      String total = c.toString();
//      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//      Map data = {
//        'Domain': d,
//        'Total':total,
//      };
//      var jsonResponse = null;
//      var response = await http.post("http://harshraj.pythonanywhere.com/candidate/put-domain-marks/", body: data,headers: {HttpHeaders.authorizationHeader:"token ${widget.usertok}"});
//      if(response.statusCode == 200)
//      {
//        jsonResponse = json.decode(response.body);
//        print('Response status: ${response.statusCode}');
//        print('Response body: ${response.body}');
//        print("level 2 marks are applied");
//      }
//      else
//        print("Error");

//    }
//   void _showDialog() {
//     // flutter defined function
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           title: new Text("ALERT"),
//           content: new Text("Select Only One Answer"),
//           actions: <Widget>[
//             // usually buttons at the bottom of the dialog
//             new FlatButton(
//               child: new Text("Close"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//   int getArraySum(List<dynamic> a,List<dynamic> b,List<dynamic> x, List<dynamic> y,String recdata){
//     int i = 0;
//     int j;
    
//     var subdomaintotal = new List<int>();

//     var c = List<int>(b.length);
//     var d =  List<int>(a.length);
//     var e = List<int>(x.length);
//     var f = List<int>(y.length);
//     int total1 = 0;
//     int total2 = 0;
//     int total3 = 0;
//     int total4 = 0;
//     int finaltotal = 0;
//     int threshold ;
//     String max;
//     for(j = 0; j <= (a.length-1); j++)
//     {
//       d[j] = int.parse(a[j]);
//     }
//     for(j= 0; j <= (b.length -1); j++)
//     {
//       c[j] = int.parse(b[j]);
//     }
//      for(j= 0; j <= (x.length -1); j++)
//     {
//       e[j] = int.parse(x[j]);
//     }
//      for(j= 0; j <= (y.length -1); j++)
//     {
//       f[j] = int.parse(y[j]);
//     }


    
//   for(i = 0; i <= (d.length - 1); i++)
//   {
//     total1 += d[i];
//   }
//   print(total1);
//   subdomaintotal.add(total1);
//    for(i = 0; i <= (c.length - 1); i++)
//   {
//     total2 += c[i];
//   }
//   print(total2);
//   subdomaintotal.add(total2);
//    for(i = 0; i <= (e.length - 1); i++)
//   {
//     total3 += e[i];
//   }
//   print(total3);
//   subdomaintotal.add(total3);
//    for(i = 0; i <= (f.length - 1); i++)
//   {
//     total4 += f[i];
//   }
//   print(total4);
//   subdomaintotal.add(total4);

//   print(subdomaintotal);
//    subdomaintotal.sort();
//    print(subdomaintotal);
//    print(subdomaintotal.first);
//    print(subdomaintotal.last);
//      for(i = 0; i <= (subdomaintotal.length - 1); i++)
//   {
//     finaltotal += subdomaintotal[i];
//   }
//  print(finaltotal);
//  threshold = (finaltotal * 0.70).floor();

//  if(finaltotal > 1)
//  {
//    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => LevelPage(tok: widget.usertok,)),
//      //  ResDomPage(resmarks1: finaltotal,round: "3rd",previousround: "2nd",maximum: recdata,usertokenvar: widget.usertok,),),
//                    );
//  }
//  else
//  {  
//     if(recdata == '1')
//     {
//        Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 2.toString(),token: widget.usertok,)),
//                    );
//     }
//      else{
//         Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>HomePage1(maxdomain: 1.toString(),token: widget.usertok)),
//                    );
//      }
//  }
  

  
//  }


//   @override
//   Widget build(BuildContext context) {
    
//      return
//         ListTile(
//            onTap: (){
           
//              setState(()  {
            
//                if(tapped == false)
//                {

//                  tapped = true;
//                  c = Colors.black;
//                  print("tapped");
//                  count = count + 1;
//                  widget.glob.add("${widget.questionDomain[widget.index].weightage.toInt()}");
               

//                  if(widget.questionDomain[widget.index].subDomain == 2 || widget.questionDomain[widget.index].subDomain == 9)
//                  {
//                    widget.mj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
//                    widget.mj.toList();
//                    print(widget.mj);
//                    print("lIST 1");

//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 3 || widget.questionDomain[widget.index].subDomain == 10)
//                  {
//                    widget.dj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
//                    print(widget.dj);
//                    print("LIST 2");
//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 5 || widget.questionDomain[widget.index].subDomain == 11)
//                  {  
//                     widget.aj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
//                      print("LIST 3");
//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 7 || widget.questionDomain[widget.index].subDomain == 13)
//                  {
//                        widget.bj.add("${widget.questionDomain[widget.index].weightage.toInt()}");
//                        print("LIST 4");
//                  }

//                }
//                else
//                {
//                  tapped = false;
//                  c = Colors.white;
//                  print("untapped");
//                  count = 0;
//                  widget.glob.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
//                    if(widget.questionDomain[widget.index].subDomain == 2 || widget.questionDomain[widget.index].subDomain == 9)
//                  {
//                    widget.mj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
//                    print(widget.mj);
//                    print("LIST 1 ELEMENT REMOVED");
                   
//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 3 || widget.questionDomain[widget.index].subDomain == 10)
//                  {
//                    widget.dj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
//                    print(widget.dj);
//                    print("LIST 2 ELEMENT REMOVED");
//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 5 || widget.questionDomain[widget.index].subDomain == 11)
//                  {
//                      widget.aj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
//                      print(widget.aj);
//                      print("LIST 3 ELEMENT REMOVED");
//                  }
//                  else if(widget.questionDomain[widget.index].subDomain == 7 || widget.questionDomain[widget.index].subDomain == 13)
//                  {     
//                        print(widget.bj);
//                         widget.bj.remove("${widget.questionDomain[widget.index].weightage.toInt()}");
//                        print("LIST 4 ELEMENT REMOVED");
//                  }

                 

                 
//                }
//                if(count > 1)
//                {
//                  _showDialog();
//                }
//                if(widget.glob.length == widget.ln)
//                {
//                  setState(() {
//                    getArraySum(widget.mj, widget.dj, widget.aj, widget.bj,widget.domaindata);
//                  });
//                }
               
              

           
               
          

//              }
//             ); 
//            },
        
          
         
//           title: new Center(child: ChoiceChip(label: Text(widget.answerText,textAlign: TextAlign.center,
//           style: new TextStyle(
//             color: c,
//             fontWeight: FontWeight.bold,),),selectedColor: Colors.lightBlueAccent,selected: tapped,)
//           ),
//       //     new Text(
//       //         widget.answerText,
//       //     textAlign: TextAlign.center,
//       //     style: new TextStyle(
//       //       color: c,
//       //       fontWeight: FontWeight.bold,
//       //     ),
          
//       // ), 
//     );
    
//   }
// }

 