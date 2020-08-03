import 'package:flutter/material.dart';
import 'QuizStartCards.dart';
import 'Blogs.dart';
import 'Courseslist.dart';
import 'package:flutter_app/view/Animation/fade_animation.dart';
class CourseMainPage extends StatelessWidget {
  CourseMainPage({Key key, this.title,this.usertoker}) : super(key: key);
final String title;
final String usertoker;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
      routes: {
        '/blogPage' : (context)=>SearchBlogsPage(usertok: usertoker,),
       '/coursePage' : (context)=>SearchCoursesPage(usertok: usertoker,),
       // '/coursePage' : (context)=>   null,//CoursePage(),
      },
    );
  }
}
class mainPage extends StatefulWidget {
  mainPage({Key key, this.title,this.usertok}) : super(key: key);
final String title;
final String usertok;
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f6fd),
      body: Container(
        padding: EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Hello CarrerConnect Aspirants", style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent
                ),),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/image/profilePic.png')
                    )
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Text('Find the Best\nCourses and\nOpportunities!!!', style: TextStyle(
              fontSize: 35,
              height: 1.3,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         courseWidget('Courses', 'Course', 'img1', '${widget.usertok}',false,true, Color(0xffe9eefa), Colors.white),
                          SizedBox(height: 20,),
                         courseWidget('Schemes', 'Government Schemes ', 'img1', '${widget.usertok}',false,false, Color(0xffe9eefa), Colors.white),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 50,),
                          courseWidget('Blogs', 'Blogs', 'img1', '${widget.usertok}',true,false, Color(0xffe9eefa), Colors.white),
                         
                        //   SizedBox(height: 20,),
                        //  courseWidget('CarrerConnect Courses', 'Course', 'img1', '${widget.usertok}',false,false, Color(0xffe9eefa), Colors.white),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       IconButton(
            //         icon: Icon(
            //           Icons.subscriptions,
            //           color: Color(0xff2657ce),
            //           size: 40,
            //         ),
            //       ),
            //       IconButton(
            //         icon: Icon(
            //           Icons.play_circle_filled,
            //           color: Color(0xff2657ce).withOpacity(0.5),
            //           size: 40,
            //         ),
            //       ),
            //       IconButton(
            //         icon: Icon(
            //           Icons.add_shopping_cart,
            //           color: Color(0xff2657ce).withOpacity(0.5),
            //           size: 40,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
 Container courseWidget(String category, String title, String img, String usertoken,bool blogs,bool corses ,Color categoryColor, Color bgColor)
  {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: InkWell(
        onTap: (){
          
          openCoursePage('$img', '$title','$usertoken',blogs,corses);
        
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),

              ),
              child: Text('$category', style: TextStyle(
                color: (categoryColor == Color(0xffe9eefa) ? Color(0xff2657ce) : Colors.white)
              ),),
            ),
            SizedBox(height: 10,),
            Text('$title', style: TextStyle(
              color: (bgColor == Color(0xffff5954)) ? Colors.white : Colors.black,
              fontSize: 20,
              height: 1,
            ),),
            SizedBox(height: 10,),
            Row(
              children: <Widget>[
                Container(
                  height: 5,
                  width: 100,
                  color: (bgColor == Color(0xffff5954)) ? Colors.red : Color(0xff2657ce),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    color: (bgColor == Color(0xffff5954)) ? Colors.white.withOpacity(0.5) : Color(0xff2657ce).withOpacity(0.5),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Hero(
              tag: Text("hh"),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/$img.png'),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void openCoursePage(String img, String title, String user,bool bl,cl)
  {
    if(cl == true)
    {
      Navigator.pushNamed(context, '/coursePage');
    }
    if(bl == true)
    {
       Navigator.pushNamed(context, '/blogPage');
    }
    
   // Navigator.pushNamed(context, '/coursePage', arguments: {'img':'$img', 'title':'$title','user':'$user'});
  }
}

// class CourseMainPage extends StatelessWidget {
//    CourseMainPage({Key key, this.title,this.usertoker}) : super(key: key);
// final String title;
// final String usertoker;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: mainPage(usertok: usertoker,),
//       routes: {
//         '/blogPage' : (context)=>SearchBlogsPage(usertok: usertoker,),
//         '/coursePage' : (context)=>SearchCoursesPage(usertok: usertoker,),
//       },
//     );
//   }


  
// }
// class mainPage extends StatefulWidget {
//   mainPage({Key key, this.title,this.usertok}) : super(key: key);
// final String title;
// final String usertok;
//   @override
//   _mainPageState createState() => _mainPageState();
// }

// class _mainPageState extends State<mainPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: true,
//       backgroundColor: Color(0xfff4f6fd),
//       body: Container(
//         padding: EdgeInsets.only(top: 40, left: 30, right: 30),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                FadeAnimation(1,Text("Hello CarrerConnect Aspirants", style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.blueAccent
//                 ),),),
//                FadeAnimation(1, Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage('assets/image/profilePic.png')
//                     )
//                   ),
//                 )
//                ),
//               ],
//             ),
//             SizedBox(height: 25,),
//            FadeAnimation(1.5, Text('Find Your Best  \nCourses and \nOpportunities !!!', style: TextStyle(
//               fontSize: 35,
//               height: 1.3,
//               fontWeight: FontWeight.w700
//             ),),),
//             SizedBox(
//               height: 10,
//             ),
//             FadeAnimation(2,
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       width: MediaQuery.of(context).size.width*0.4,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           courseWidget('Courses', 'Coding Course', 'img1', '${widget.usertok}',false,true, Color(0xffff6a65), Color(0xffff5954)),
//                           SizedBox(height: 20,),
//                           courseWidget('Social Media', 'Blogs', 'img2', '${widget.usertok}',true,false,Color(0xffe9eefa), Colors.white),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width*0.4,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           SizedBox(height: 50,),
//                           courseWidget('Schemes', 'Government Schemes', 'img3','${widget.usertok}',false,false, Color(0xffe9eefa), Colors.white),
//                           SizedBox(height: 20,),
//                           courseWidget('Graphic Design', 'Fundamentals of Design', 'img4', '${widget.usertok}',false,false,Color(0xffbdcddfa), Color(0xffcedaff)),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             ),
//             // Container(
//             //   padding: EdgeInsets.all(20),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: <Widget>[
//             //       IconButton(
//             //         icon: Icon(
//             //           Icons.subscriptions,
//             //           color: Color(0xff2657ce),
//             //           size: 40,
//             //         ),
//             //       ),
//             //       IconButton(
//             //         icon: Icon(
//             //           Icons.play_circle_filled,
//             //           color: Color(0xff2657ce).withOpacity(0.5),
//             //           size: 40,
//             //         ),
//             //       ),
//             //       IconButton(
//             //         icon: Icon(
//             //           Icons.account_circle,
//             //           color: Color(0xff2657ce).withOpacity(0.5),
//             //           size: 40,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
//   Container courseWidget(String category, String title, String img, String usertoken,bool blogs,bool corses ,Color categoryColor, Color bgColor)
//   {
//     return Container(
//       padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.all(Radius.circular(30)),
//       ),
//       child: InkWell(
//         onTap: (){
          
//           openCoursePage('$img', '$title','$usertoken',blogs,corses);
        
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: categoryColor,
//                 borderRadius: BorderRadius.all(Radius.circular(20)),

//               ),
//               child: Text('$category', style: TextStyle(
//                 color: (categoryColor == Color(0xffe9eefa) ? Color(0xff2657ce) : Colors.white)
//               ),),
//             ),
//             SizedBox(height: 10,),
//             Text('$title', style: TextStyle(
//               color: (bgColor == Color(0xffff5954)) ? Colors.white : Colors.black,
//               fontSize: 20,
//               height: 1,
//             ),),
//             SizedBox(height: 10,),
//             Row(
//               children: <Widget>[
//                 Container(
//                   height: 5,
//                   width: 100,
//                   color: (bgColor == Color(0xffff5954)) ? Colors.red : Color(0xff2657ce),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 5,
//                     color: (bgColor == Color(0xffff5954)) ? Colors.white.withOpacity(0.5) : Color(0xff2657ce).withOpacity(0.5),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 10,),
//             Hero(
//               tag: '$img',
//               child: Container(
//                 height: 80,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/image/$img.png'),
//                   )
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   void openCoursePage(String img, String title, String user,bool bl,cl)
//   {
//     if(cl == true)
//     {
//       Navigator.pushNamed(context, '/coursePage');
//     }
//     if(bl == true)
//     {
//        Navigator.pushNamed(context, '/blogPage');
//     }
    
//    // Navigator.pushNamed(context, '/coursePage', arguments: {'img':'$img', 'title':'$title','user':'$user'});
//   }
// }