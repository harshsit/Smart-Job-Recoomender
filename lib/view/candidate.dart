// import'package:flutter/material.dart';
// import'package:flutter_app/view/checkbox.dart';
// class MyStatefulWidget extends StatefulWidget {
//   MyStatefulWidget({Key key}) : super(key: key);

//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   bool _isSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return LabeledCheckbox(
//       label: 'Candidate',
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       value: _isSelected,
//       onChanged: (bool newValue) {
//         setState(() {
//           _isSelected = newValue;
//         });
//       },
//     );
//   }
// }