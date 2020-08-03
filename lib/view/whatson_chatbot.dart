 import 'package:flutter/material.dart';
 import 'package:watson_assistant_v2/watson_assistant_v2.dart';
 import 'dart:ffi';
 
 class ChatbotPage extends StatefulWidget {
   ChatbotPage({Key key, this.title}) : super(key: key);
 
   final String title;
 
   @override
   _ChatbotPageState createState() => _ChatbotPageState();
 }
 
 class _ChatbotPageState extends State<ChatbotPage> {
   String _text;
   WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
     version: '2019-02-28',
     username: 'apikey',
     apikey: 'WchgYh4MfCBcC4q1bQ5Bd1HMtn2xqRrcY7-ILIH9g36m',
     assistantID: '8e0a20dc-df2c-4e4e-9417-99011cbd48ac',
     url: 'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/639a4505-456c-434d-8847-63e3f9485311/v2',
   );
 
   WatsonAssistantApiV2 watsonAssistant;
   WatsonAssistantResponse watsonAssistantResponse;
   WatsonAssistantContext watsonAssistantContext =
       WatsonAssistantContext(context: {});
 
   final myController = TextEditingController();
 
   void _callWatsonAssistant() async {
     watsonAssistantResponse = await watsonAssistant.sendMessage(
         myController.text, watsonAssistantContext);
     setState(() {
       _text = watsonAssistantResponse.resultText;
     });
     watsonAssistantContext = watsonAssistantResponse.context;
     myController.clear();
   }
 
   @override
   void initState() {
     super.initState();
     watsonAssistant =
         WatsonAssistantApiV2(watsonAssistantCredential: credential);
     _callWatsonAssistant();
   }
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
    
      

       appBar: AppBar(
         
         title: Text('CareerConnect Chatbot'),
         centerTitle: true,
         actions: <Widget>[
           IconButton(
             icon: Icon(
               Icons.restore,
             ),
             onPressed: () {
               watsonAssistantContext.resetContext();
               setState(() {
                 _text = null;
               });
             },
           )
         ],
       ),
       
       body:Container(
      padding: EdgeInsets.symmetric(horizontal: 8),

     
      color: Colors.white,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.end,
        children: <Widget>[
          Row(children: <Widget>[
             Container(
            alignment: Alignment.topRight,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                 _text != null ? '$_text' : 'Chatbot Response Here',
                style: TextStyle(
                  color: Colors.white,
               
                ),
              ),
            ),
          ),
          ],),
            SizedBox(
                 height: .0 ,

               ),

         Align(alignment: Alignment.bottomCenter,
         child: Row(children: <Widget>[
           
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            flex: 5,
            child: TextField(
              controller: myController,
              decoration: InputDecoration.collapsed(
             
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLines: null,
              minLines: null,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Theme.of(context).primaryColor,
            onPressed: _callWatsonAssistant,
          ),
         ],),
         ),
          SizedBox(
                 height: 35.0 ,

               ),

         
          
        ],
      ),
    ),
    resizeToAvoidBottomPadding: true,
    resizeToAvoidBottomInset: true,

      //   Scaffold(
      //    backgroundColor: Colors.white,
      //    resizeToAvoidBottomPadding: true,
      //    resizeToAvoidBottomInset: true,


      //    body:
         
      //     Padding(
      //     padding: EdgeInsets.only(
      //        bottom: MediaQuery.of(context).viewInsets.bottom),
      //      child: Column(
      //        mainAxisAlignment: MainAxisAlignment.center,
      //        crossAxisAlignment: CrossAxisAlignment.stretch,
      //        mainAxisSize: MainAxisSize.max,


      //        children: <Widget>[
      //            SizedBox(
      //            height: 8.0,
      //          ),
      //           Text(
      //            _text != null ? '$_text' : 'Chatbot Response Here',
      //            style: TextStyle(backgroundColor: Colors.blue,color: Colors.white,)
      //          ),
      //           SizedBox(
      //            height: 8.0,
      //          ),
               
      //          TextField(
      //            controller: myController,
      //            decoration: InputDecoration(
      //              hintText: 'Your Input to the chatbot',
      //              contentPadding:
      //                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      //              border: OutlineInputBorder(
      //                borderRadius: BorderRadius.all(Radius.circular(32.0)),
      //              ),

      //              enabledBorder: OutlineInputBorder(
      //                borderSide:
      //                    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      //                borderRadius: BorderRadius.all(Radius.circular(32.0)),
      //              ),
      //              focusedBorder: OutlineInputBorder(
      //                borderSide:
      //                    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      //                borderRadius: BorderRadius.all(Radius.circular(32.0)),
      //              ),
      //            ),
      //            maxLength: null,

      //          ),

               
              
              
              
      //         //  SizedBox(
      //         //    height: 8.0,
      //         //  ),
      //         //  Text(
      //         //    _text != null ? '$_text' : 'Chatbot Response Here',
      //         //    style: Theme.of(context).textTheme.display1,
      //         //  ),
      //         //  SizedBox(
      //         //    height: 24.0,
      //         //  ),
      //        ],
      //      ),
      //    ),
      //  ),


      //  floatingActionButton: FloatingActionButton(
      //    onPressed: _callWatsonAssistant,
      //    child: Icon(Icons.send),
      //  ),
     );
    

   }
 
   @override
   void dispose() {
     myController.dispose();
     super.dispose();
   }
 }