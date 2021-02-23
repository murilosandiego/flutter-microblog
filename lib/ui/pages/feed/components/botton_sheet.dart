// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../post_viewmodel.dart';
// import 'modal_post.dart';
// import 'modal_remove.dart';

// Future getBottomSheet({
//   @required BuildContext context,
//   @required NewsViewModel news,
// }) {
//   return Get.bottomSheet(
//     Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Wrap(
//         children: <Widget>[
//           ListTile(
//               title: Text(
//                 'Editar',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               onTap: () {
//                 Get.back();
//                 return showModalPost(
//                   context,
//                   news: news,
//                 );
//               }),
//           ListTile(
//             title: Text(
//               'Remover',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             onTap: () {
//               Get.back();
//               return showModalRemove(
//                 news: news,
//                 context: context,
//               );
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
