// import 'package:flutter/material.dart';
// class LabeledCheckbox extends StatelessWidget {

//   const LabeledCheckbox({
//     this.label,
//     this.padding,
//     this.value,
//     this.onChanged,
//   });

//   final String label;
//   final EdgeInsets padding;
//   final bool value;
//   final Function onChanged;


//   @override
//   Widget build(BuildContext context) {
//     bool Is_Candidate = false;
//     bool Is_University = false;
//     bool Is_Organization = false;
//     return InkWell(
//       onTap: () {
//         onChanged(!value);
//       },
//       child: Padding(
//         padding: padding,
//         child: Row(
//           children: <Widget>[
//             Expanded(child: Text(label)),
//             Checkbox(
//               value: value,
//               onChanged: (bool newValue) {
//                 onChanged(newValue);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }