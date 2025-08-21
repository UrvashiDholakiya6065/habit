// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class WeekSelector extends StatefulWidget {
//   @override
//   _WeekSelectorState createState() => _WeekSelectorState();
// }
//
// class _WeekSelectorState extends State<WeekSelector> {
//   final List<String> days = ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
//   final List<int> dates = [18, 19, 20, 21, 22, 23, 24];
//
//   Set<int> selectedDateIndices = {};
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 90,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: days.length,
//         itemBuilder: (context, index) {
//           bool isSelected = selectedDateIndices.contains(index);
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 if (isSelected) {
//                   selectedDateIndices.remove(index);
//                 } else {
//                   selectedDateIndices.add(index);
//                 }
//               });
//             },
//             child: Container(
//               width: 60,
//               margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected ? Colors.yellow[100] : Colors.white,
//                 border: Border.all(
//                   color: isSelected ? Colors.orange : Colors.grey.shade400,
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(days[index],
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 4),
//                   CircleAvatar(
//                     radius: 14,
//                     backgroundColor: isSelected ? Colors.orange : Colors.transparent,
//                     child: Text(
//                       dates[index].toString(),
//                       style: TextStyle(
//                           color: isSelected ? Colors.white : Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
