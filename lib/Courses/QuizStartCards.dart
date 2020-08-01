import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'Blogs.dart';
class QuizStartPage extends StatefulWidget {
  @override
  _QuizStartPageState createState() => _QuizStartPageState();
}

class _QuizStartPageState extends State<QuizStartPage> {

 static List itemss = ["Technology","Marketting","Fashion","Buisness"];
  var selecteditem;
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Color(0xffe1eaff),
          ),
          child: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff2657ce),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Select as ANY ONE as per your choice', style: TextStyle(
              color: Color(0xff2657ce),
              fontSize: 27,
            ),),
            Text('CarrerConnect Specialized Test', style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 20
            ),),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xffcedaff),
              ),
              child: Hero(
                tag: Text("hhh"),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage('assets/image/img2.png'),
                    )
                  ),
                  child: DropdownButton(items: null, onChanged: null),
                ),


              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Color(0xffcedaff),
              ),
              child: Hero(
                tag: Text("hhh"),
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage('assets/image/img1.png'),
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      Row(children: <Widget>[
                      
                       new DropdownButton<String>(
                         hint: Text("Select Your Domain: $selecteditem",style: TextStyle(backgroundColor: Colors.white,fontWeight: FontWeight.bold),),
                         iconSize: 24.0,
                         onChanged: (value) {
                           selecteditem = value;
                         },
                       items: <String>['Technology', 'Marketting', 'Fashion', 'Journalism'].map((String value) {
                       return new DropdownMenuItem<String>(

                       value: value,
                       child: new Text(value),
                       onTap: () {
                         selecteditem = value;
                       },
                       );
                       }).toList(),
                      //  onChanged: (value) {
                      
                      //  },
                       ),
                      SizedBox(width: 2.0,)

                      ],
                      
                      )
                      
                      

                    ],
                  )
                ),


              ),
              
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Text('Course', style: TextStyle(
            //       fontSize: 25,
            //       fontWeight: FontWeight.w600,
            //     ),),
            //     // Container(
            //     //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            //     //   decoration: BoxDecoration(
            //     //     borderRadius: BorderRadius.all(Radius.circular(15)),
            //     //     color: Color(0xffd3defa),
            //     //   ),
            //     //   child: Row(
            //     //     children: <Widget>[
            //     //       Container(
            //     //         width: 35,
            //     //         child: IconButton(
            //     //           icon: Icon(
            //     //             Icons.timer,
            //     //             color: Colors.blue,
            //     //           ),
            //     //         ),
            //     //       ),
            //     //       Text("3 Hours, 20 Min", style: TextStyle(
            //     //         color: Colors.black.withOpacity(0.7)
            //     //       ),)
            //     //     ],
            //     //   ),
            //     // )
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: <Widget>[
            //         SearchBlogsPage(usertok: "$uservariable"),
            //         // productListing('Introduction', 'Introduction of the course', 'active'),
            //         // productListing('Language of Color', 'Learn about the language of..', 'inactive'),
            //         // productListing('Psychology of Color', 'Learn about the psychology of..', 'inactive'),
            //         // productListing('Language of Color', 'Learn about the language of..', 'inactive')
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
//   Column productListing(String title, String info, String activeOrInactive)
//   {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 10,),
//         Row(
//           children: <Widget>[
//             Container(
//               width: 50,
//                 height: 50,
//               decoration: BoxDecoration(
//                 color: (activeOrInactive == 'active') ? Color(0xff2657ce) : Color(0xffd3defa),
//                 borderRadius: BorderRadius.all(Radius.circular(17)),
//               ),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.play_arrow,
//                   color: (activeOrInactive == 'active') ? Colors.white : Color(0xff2657ce),
//                 ),
//               ),
//             ),
//             SizedBox(width: 15,),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text('$title', style: TextStyle(
//                   fontSize: 20,
//                 ),),
//                 Text('$info', style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey
//                 ),)
//               ],
//             )
//           ],
//         ),
//         Center(
//           child: Container(
//             margin: EdgeInsets.symmetric(vertical: 10),
//             width: MediaQuery.of(context).size.width*0.85,
//             height: 0.5,
//             color: Colors.grey,
//           ),
//         ),
//         SizedBox(height: 10,),
//       ],
//     );
//   }
// }
}