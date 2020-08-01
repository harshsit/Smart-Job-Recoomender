

import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/view/viewprofilemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'Animation/fade_animation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'MACHINE.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.domain,this.subdomain,this.rating,this.tok,this.user,this.password}) : super(key: key);
  final String domain;
  final String subdomain;
  final String rating;
  final String tok;
  final String user;
  final String password;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   File _file;
   bool _isLoading = false;
   double _progressValue;
   String tk;
   bool profileverify = false;
  var  selectedType;
  final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController socialController = new TextEditingController();
  TextEditingController familyController = new TextEditingController();
  TextEditingController residenceController = new TextEditingController();
  TextEditingController bioController = new TextEditingController();
   TextEditingController hoursController = new TextEditingController();
    TextEditingController expController = new TextEditingController();
   List _myActivities;
   List _myActivities1;
   bool verifyskills = false;
   var skillsanalysis = new List();

signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password
    };
    var jsonResponse = null;

    var response = await http.post(
        "https://harshraj.pythonanywhere.com/account/login/", body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        sharedPreferences.setString("user", username);
         tk = sharedPreferences.getString("token");
        print(tk);
        // Navigator.of(this.context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (BuildContext context) => FadeAnimation(1,ProfilePage(tok: tk,))), (
        //     Route<dynamic> route) => false);
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  Future getFile() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      onFileLoading: null,
    );

    setState(() {
      _file = file;
    });
  }
   _uploadFile(filePath,) async {
    String fileName = basename(filePath.path);
    print("file base name:$fileName");

    try {
      FormData formData = new FormData.fromMap({
        "Name": nameController.text,
        "Address": addressController.text,
        "Resume": await MultipartFile.fromFile(
            filePath.path, filename: fileName),
         "Bio": bioController.text,
         "Time": hoursController.text,
         "Socialmedia": 1.toString(),
         "Familyincome": familyController.text,
         "Residence": 3.toString(),
         "Experience": expController.text,
      });
       var jsonResponse = null;
      Response response = await Dio().post(
          "http://harshraj.pythonanywhere.com/candidate/create/",
          data: formData, options: Options(headers: {
        "Authorization": "token $tk"
      },));
     // print("${response.data}");
      print("File upload response: $response");
      if("${response.data['sucess']}" == 'true')
      {
        setState(() {
          profileverify = true;

        });
        
         Navigator.of(this.context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => FadeAnimation(0.0,MainPage(usertok: tk,))), (Route<dynamic> route) => false);
      }
      else
      {
        print("error");
      }
     
      _showSnackBarMsg("${response.data}");
    } catch (e) {
      print("expectation Caugch: $e");
    }

  }
   _uploadResumeAnalysis(filePath,) async {
    String fileName = basename(filePath.path);
    print("file base name:$fileName");

    try {
      FormData formData = new FormData.fromMap({
         
        "Resume": await MultipartFile.fromFile(
            filePath.path, filename: fileName),
        "username": nameController.text,
      });

      Response response = await Dio().post(
          "https://sihml.pythonanywhere.com/analysis/analysis/",
          data: formData,
      );
        print("${response.data['skills']}");
        skillsanalysis.addAll(response.data['skills']);
        print(skillsanalysis);
     // print("File upload response: $response");
      //skills("${response.data['skills']}");
      _showSnackBarMsg(response.data);
    } catch (e) {
      print("expectation Caugch: $e");
    }

  }



   Future _showSnackBarMsg(dynamic msg) {
    // Scaffold.of().showSnackBar(SnackBar(content: Text("")));
    _scaffoldstate.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  Future skills(String a)
  {
    FilterChip(label: Text("${a}"), onSelected: null);
  }

 Widget  skillList(){
    return 
    ListView.builder(
      shrinkWrap: true,
      itemCount: skillsanalysis.length == null ? 0 :  skillsanalysis.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context,i,)=>Chip(
        
        label: skillsanalysis[i],
        backgroundColor: Colors.grey,
      ),

    );
    

  }
   @override
  void initState() {
    // TODO: implement initState
     signIn(widget.user,widget.password);
    // verifyresumeskills();
    super.initState();
     _progressValue = 0.0;
    
     //signIn(widget.user,widget.password);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         
          title: Container(
            alignment: Alignment.center,
            child: Text("Profile Creation",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
         
        ),
        body:Center(
        
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            :
         Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
               Center(child: Text("General Details")),
              SizedBox(height: 20.0),
               new TextField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Enter your Unique Username',
                  labelText: 'Username',
                  
                ),
                controller: nameController,
              ),
              new TextField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.adjust,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Enter your Experience',
                  labelText: 'Experience',
                ),
                keyboardType: TextInputType.number,
                controller: expController,
              ),
             
              
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.envelope,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Enter your Address',
                  labelText: 'Address',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: addressController,
              ),
              
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.clipboard,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Enter your Bio',
                  labelText: 'Bio',
                ),
                keyboardType: TextInputType.text,
                controller: bioController,
                maxLines: null,
                minLines: 1,
              ),
             
              RaisedButton(
              child: Text("Select Resume in PDF format only"),
              onPressed: getFile,
                       ),
               SizedBox(height: 20.0),
              Text("${_file}"),
             
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
                 
      
              //   //   RaisedButton(
              //   //       color: Color(0xff11b719),
              //   //       textColor: Colors.white,
              //   //       child: Padding(
              //   //           padding: EdgeInsets.all(10.0),
              //   //           child: Row(
              //   //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   //             children: <Widget>[
              //   //               Text("Upload Resume", style: TextStyle(fontSize: 15.0)),
              //   //             ],
              //   //           )),
              //   //           focusColor: Colors.deepPurple,
              //   //           onPressed: null,
              //   //           // () {
              //   //           //   //_uploadResumeAnalysis(_file);
                            

              //   //           // },
              //   //       // onPressed:
              //   //       // (){
              //   //       //    _uploadResumeAnalysis(_file);
                         
              //   //       // },
                           
              //   //           //_uploadResumeAnalysis(_file) 

              //   //       shape: new RoundedRectangleBorder(
              //   //           borderRadius: new BorderRadius.circular(30.0))),
                      

              

              //   // ],
              // ),
              
              SizedBox(height: 20.0),
              //skillList(),
             // skillsanalysis.length == null ?  Text(" "):  Text("${skillsanalysis}"),
               Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Social Media Usage',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Instagram",
                      "value": "1",
                    },
                    {
                      "display": "Snapchat",
                      "value": "2",
                    },
                    {
                      "display": "Twitter",
                      "value": "3",
                    },
                    {
                      "display": "Facebook",
                      "value": "4",
                    },
                    
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Please choose one or more',
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;

                    });
                  },
                ),
              ),
              
              SizedBox(height: 10.0),
                new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.adjust,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'Usage Hours',
                  labelText: 'Hours',
                ),
                keyboardType: TextInputType.number,
                controller: hoursController,
              ),
               SizedBox(height: 10.0),
                  Container(
                padding: EdgeInsets.all(16),
                child: MultiSelectFormField(
                  autovalidate: false,
                  titleText: 'Residence',
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select ONLY one';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Metro",
                      "value": "1",
                    },
                    {
                      "display": "Urban",
                      "value": "2",
                    },
                    {
                      "display": "Semi-Urban",
                      "value": "3",
                    },
                    {
                      "display": "Rural",
                      "value": "4",
                    },
                    
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  // required: true,
                  hintText: 'Please choose one or more',
                  initialValue: _myActivities1,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities1 = value;

                    });
                  },
                ),
              ),
                   SizedBox(height: 10.0),
                new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(
                    FontAwesomeIcons.adjust,
                    color: Colors.deepPurple,
                  ),
                  hintText: 'For: eg 300000',
                  labelText: 'Family Income',
                ),
                keyboardType: TextInputType.number,
                controller: familyController,
              ),
              SizedBox(
                height: 100.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Submit", style: TextStyle(fontSize: 25.0)),
                            ],
                          )),
                      onPressed: nameController.text == "" || addressController.text == "" || bioController.text =="" || hoursController.text =="" ||  familyController == "" || expController == "" ? null : () {
                     setState(() {
                     _isLoading = true;
                       });
                        _uploadResumeAnalysis(_file);
                       _uploadFile(_file);
                      //signUp(emailController.text,usernameController.text,passwordController.text,confirm_passwordController.text,usertype1.toString(),usertype2.toString(),usertype3.toString());
                     },

                     ),
                ],
              ),
            ],
          ),
        )
    ),);
  }
}



// class ProfilePage extends StatefulWidget {
//   ProfilePage({Key key, this.domain,this.subdomain,this.rating,this.tok}) : super(key: key);
//   final String domain;
//   final String subdomain;
//   final String rating;
//   final String tok;
//   @override
//   MapScreenState createState() => MapScreenState();
// }

// class MapScreenState extends State<ProfilePage>
//     with SingleTickerProviderStateMixin {
//   File _file;
//   File _image;
//   final GlobalKey<ScaffoldState> _scaffoldstate = new GlobalKey<
//       ScaffoldState>();
//   bool _status = true;
//   final FocusNode myFocusNode = FocusNode();
//    TextEditingController nameController = new TextEditingController();
//    TextEditingController addressController = new TextEditingController();

//   Future getFile() async {
//     File file = await FilePicker.getFile();

//     setState(() {
//       _file = file;
//     });
//   }
//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image = image;
//       print('Image Path $_image');
//     });
//   }
//   Future resp() async{

//   }

//   void _uploadFile(filePath,) async {
//     String fileName = basename(filePath.path);
//     print("file base name:$fileName");

//     try {
//       FormData formData = new FormData.fromMap({
//         "Name": "tester_manish",
//         "Address": "tester",
//         "Resume": await MultipartFile.fromFile(
//             filePath.path, filename: fileName),
//          "Bio": " hbhjbb jbbj njjbjb",
//       });

//       Response response = await Dio().post(
//           "http://harshraj.pythonanywhere.com/candidate/create/",
//           data: formData, options: Options(headers: {
//         "Authorization": "token ${widget.tok}"
//       },));
//       print("File upload response: $response");
//       _showSnackBarMsg(response.data);
//     } catch (e) {
//       print("expectation Caugch: $e");
//     }

//   }

//   Future _showSnackBarMsg(dynamic msg) {
//     // Scaffold.of().showSnackBar(SnackBar(content: Text("")));
//     _scaffoldstate.currentState.showSnackBar(SnackBar(content: Text(msg)));
//   }


//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     nameController = TextEditingController();
//     addressController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         body: new Container(
//           color: Colors.white,
//           child: new ListView(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   new Container(
//                     height: 250.0,
//                     color: Colors.white,
//                     child: new Column(
//                       children: <Widget>[
//                         Padding(
//                             padding: EdgeInsets.only(left: 20.0, top: 20.0),
//                             child: new Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[

//                                 new Icon(
//                                   Icons.arrow_back_ios,
//                                   color: Colors.black,
//                                   size: 22.0,
//                                 ),
//                                 Padding(
//                                     padding: EdgeInsets.only(left: 25.0),
//                                     child: Center(child: new Text(
//                                         'PROFILE', textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20.0,
//                                             fontFamily: 'sans-serif-light',
//                                             color: Colors.black)),
//                                     )
//                                 ),
//                               ],
//                             )),
//                         Padding(
//                           padding: EdgeInsets.only(top: 20.0),
//                           child: new Stack(
//                               fit: StackFit.loose, children: <Widget>[
//                             new Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 new Container(
//                                   child: CircleAvatar(
//                                     radius: 70,
//                                     backgroundColor: Color(0xff476cfb),
//                                     child: ClipOval(
//                                       child: new SizedBox(
//                                         width: 120.0,
//                                         height: 120.0,
//                                         child: (_image!=null)?Image.file(
//                                           _image,
//                                           fit: BoxFit.fill,
//                                         ):Image.network(
//                                           "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
// //                                    width: 140.0,
// //                                    height: 140.0,
// //                                    decoration: new BoxDecoration(
// //                                      shape: BoxShape.circle,
// //                                      image: new DecorationImage(
// //                                        image:
// //                                        new ExactAssetImage(
// //                                            'assets/profile.png'),
// //                                        fit: BoxFit.cover,
// //                                      ),
// //                                    )
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                                 padding: EdgeInsets.only(
//                                     top: 90.0, right: 100.0),
//                                 child: new Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,

//                                  children: <Widget>[
//                                 IconButton(
//                                    icon: Icon(
//                                     Icons.camera_alt,
//                                     size: 30.0,
//                                      color: Colors.deepPurple,
//                                 ),
//                                   onPressed: () {
//                                     getImage();
//                                   },
//                                 )
// //                                    new CircleAvatar(
// //                                      backgroundColor: Colors.greenAccent,
// //                                      radius: 25.0,
// //                                      child: new Icon(
// //                                        Icons.camera_alt,
// //                                        color: Colors.white,
// //                                      ),
// //
// //                                    )
//                                  ],
//                                 )),
//                           ]),
//                         )
//                       ],
//                     ),
//                   ),
//                   new Container(
//                     color: Color(0xffFFFFFF),
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 25.0),
//                       child: new Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 25.0),
//                               child: new Row(
//                                 mainAxisAlignment: MainAxisAlignment
//                                     .spaceBetween,
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   new Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       new Text(
//                                         'Parsonal Information',
//                                         style: TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   new Column(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       _status
//                                           ? _getEditIcon()
//                                           : new Container(),
//                                     ],
//                                   )

//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 25.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   new Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       new Text(
//                                         'Name',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 2.0),
//                               child: new Row(
//                                   mainAxisSize: MainAxisSize.max,
//                                   children: <Widget>[
//                                     new Flexible(
//                                       child:
//                                       new TextField(
//                                         controller: nameController,
//                                         decoration: const InputDecoration(
//                                           hintText: "Enter Your Name",
//                                         ),
//                                         enabled: !_status,
//                                         autofocus: !_status,

//                                       ),
//                                     ),


//                                   ]
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 25.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   new Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       new Text(
//                                         'Address',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 2.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   new Flexible(
//                                     child: new TextField(
//                                       controller: addressController,
//                                       decoration: const InputDecoration(
//                                           hintText: "Enter Your Address"),
//                                       enabled: !_status,
//                                     ),
//                                   ),
//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 25.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   new Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       new Text(
//                                         'Resume',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 2.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   RaisedButton(
//                                     child: Text("Select File"),
//                                     onPressed: getFile,
//                                   ),


//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 2.0),
//                               child: new Column(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   Text("${_file}"),
//                                 ],
//                               )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 2.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       RaisedButton(
//                                           child: Text("upload"),
//                                           onPressed: () {
//                                          //   _uploadFile(_file);
//                                           }),
//                                       SizedBox(width: 30.0,),
//                                       CircularProgressIndicator(

//                                       )
//                                     ]
//                                   ),
// //                                  RaisedButton(
// //                                      child: Text("upload"),
// //                                      onPressed: () {
// //                                        _uploadFile(_file);
// //                                      })
//                                 ],
//                               )),

//                           // Padding(
//                           // padding: EdgeInsets.only(
//                           //     left: 25.0, right: 25.0, top: 2.0),
//                           // child: new Row(
//                           //   mainAxisSize: MainAxisSize.max,
//                           //   children: <Widget>[
//                           //     Text("${response}"),
//                           //   ],
//                           // )),
//                           Padding(
//                               padding: EdgeInsets.only(
//                                   left: 25.0, right: 25.0, top: 25.0),
//                               child: new Row(
//                                 mainAxisSize: MainAxisSize.max,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       child: new Text(
//                                         'Marks are Reflectled on Dashboard if you have Taken Test',
//                                         style: TextStyle(
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ),

//                                   ),


//                                 ],
//                               )),
// //                          Padding(
// //                              padding: EdgeInsets.only(
// //                                  left: 25.0, right: 25.0, top: 25.0),
// //                              child: new Row(
// //                                mainAxisSize: MainAxisSize.max,
// //                                mainAxisAlignment: MainAxisAlignment.start,
// //                                children: <Widget>[
// //                                  Expanded(
// //                                    child: Container(
// //                                      child: new Text(
// //                                        'Apt SubDoamin: ${widget.subdomain}',
// //                                        style: TextStyle(
// //                                            fontSize: 16.0,
// //                                            fontWeight: FontWeight.bold),
// //                                      ),
// //                                    ),
// //
// //                                  ),
// //
// //
// //                                ],
// //                              )),
// //                          Padding(
// //                              padding: EdgeInsets.only(
// //                                  left: 25.0, right: 25.0, top: 25.0),
// //                              child: new Row(
// //                                mainAxisSize: MainAxisSize.max,
// //                                mainAxisAlignment: MainAxisAlignment.start,
// //                                children: <Widget>[
// //                                  Expanded(
// //                                    child: Container(
// //                                      child: new Text(
// //                                        'Job Recommended in SubDomain :${widget
// //                                            .subdomain}',
// //                                        style: TextStyle(
// //                                            fontSize: 16.0,
// //                                            fontWeight: FontWeight.bold),
// //                                      ),
// //                                    ),
// //
// //                                  ),
// //
// //
// //                                ],
// //                              )),
//                           // Padding(
//                           //     padding: EdgeInsets.only(
//                           //         left: 25.0, right: 25.0, top: 2.0),
//                           //     child: new Row(
//                           //       mainAxisSize: MainAxisSize.max,
//                           //       mainAxisAlignment: MainAxisAlignment.start,
//                           //       children: <Widget>[
//                           //         Flexible(
//                           //           child: Padding(
//                           //             padding: EdgeInsets.only(right: 10.0),
//                           //             child: new TextField(
//                           //               decoration: const InputDecoration(
//                           //                   hintText: "Enter Pin Code"),
//                           //               enabled: !_status,
//                           //             ),
//                           //           ),
//                           //           flex: 2,
//                           //         ),
//                           //         Flexible(
//                           //           child: new TextField(
//                           //             decoration: const InputDecoration(
//                           //                 hintText: "Enter State"),
//                           //             enabled: !_status,
//                           //           ),
//                           //           flex: 2,
//                           //         ),
//                           //       ],
//                           //     )),
//                           !_status ? _getActionButtons() : new Container(),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   // @override
//   // void dispose() {
//   //   // Clean up the controller when the Widget is disposed
//   //   myFocusNode.dispose();
//   //   super.dispose();
//   // }

//   Widget _getActionButtons() {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
//       child: new Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                     child: new Text("Save"),
//                     textColor: Colors.white,
//                     color: Colors.green,
//                     onPressed: nameController.text == "" ||
//                         addressController.text == "" ? null :
//                         () {
//                       setState(() {
//                         _status = true;
//                         _uploadFile(_file);
//                         //Navigator.pop(context);

//                       });
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20.0)),
//                   )),
//             ),
//             flex: 2,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                     child: new Text("Cancel"),
//                     textColor: Colors.white,
//                     color: Colors.red,
//                     onPressed: () {
//                       setState(() {
//                         _status = true;
//                         // FocusScope.of(context).requestFocus(new FocusNode());
//                         //  Navigator.pop(context);
//                       });
//                     },
//                     shape: new RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(20.0)),
//                   )),
//             ),
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _getEditIcon() {
//     return new GestureDetector(
//       child: new CircleAvatar(
//         backgroundColor: Colors.deepPurple,
//         radius: 14.0,
//         child: new Icon(
//           Icons.edit,
//           color: Colors.white,
//           size: 16.0,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           _status = false;
//         });
//       },
//     );
//   }
// }