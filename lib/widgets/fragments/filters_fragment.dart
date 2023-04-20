// import 'package:flutter/material.dart';
//
//
// Widget filtersFragment(){
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//     height: 60,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: [
//         Container(
//           padding: EdgeInsets.all(10.0),
//           margin: EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: Colors.black54),
//           child: InkWell(
//             onTap: () {
//               openFilterDialog();
//             },
//             child: const Text("Difficulty", style: TextStyle(color: Colors.white),),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(10.0),
//           margin: EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: Colors.black54),
//           child: InkWell(
//             onTap: () {
//               openFilterDialogMeal();
//             },
//             child: const Text("Meal Type", style: TextStyle(color: Colors.white),),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(10.0),
//           margin: EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: Colors.black54),
//           child: InkWell(
//             onTap: () {
//               openFilterDialogSeason();
//             },
//             child: const Text("Season", style: TextStyle(color: Colors.white),),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(10.0),
//           margin: EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: Colors.black54),
//           child: InkWell(
//             onTap: () {
//               openFilterDialogDietry();
//             },
//             child: const Text("Dietary level", style: TextStyle(color: Colors.white),),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.all(10.0),
//           margin: EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13.0),
//               color: Colors.black54),
//           child: InkWell(
//             onTap: () {
//               openFilterDialogHealthy();
//             },
//             child: const Text("Healthy factors", style: TextStyle(color: Colors.white),),
//           ),
//         ),
//
//       ],
//     ),
//   );
// }