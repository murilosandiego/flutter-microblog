// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../feed_presenter.dart';
// import '../post_viewmodel.dart';

// Future<void> showModalRemove({
//   @required NewsViewModel news,
//   @required BuildContext context,
// }) {
//   final presenter = Get.find<FeedPresenter>();

//   return showDialog(
//     context: context,
//     builder: (_) => AlertDialog(
//       title: Text('Remover publicação?'),
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20.0))),
//       actions: [
//         TextButton(
//           onPressed: () => Get.back(),
//           child: Text(
//             'Cancelar',
//             style: TextStyle(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//         TextButton(
//           onPressed: () {
//             Get.back();
//             presenter.remove(news.id);
//           },
//           child: Text(
//             'Remover',
//             style: TextStyle(
//               color: Theme.of(context).primaryColor,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
