// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tenbytes/widgets/auth_circle.dart';

// class PostTile extends StatelessWidget {
//   const PostTile({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               AuthCircle(
//                   boxHeight: 45,
//                   boxWidth: 45,
//                   boxColor: Colors.blue,
//                   svgPath: 'assets/Group1.svg'),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Riya smith',
//                       style:
//                           TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           '8m.',
//                           style: TextStyle(fontSize: 12),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(
//                           Icons.vpn_lock_rounded,
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Text(
//             " Lorem ipsum, or lipsumas it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorumfor use in a type specimen book."),
//         SizedBox(height: 5),
//         Image.asset(
//           'assets/fb_post.png',
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             Icon(Icons.logo_dev_rounded),
//             SizedBox(
//               width: 35,
//             ),
//             Icon(Icons.comment),
//             SizedBox(
//               width: 35,
//             ),
//             Icon(Icons.share),
//           ],
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         Row(
//           children: [
//             Icon(Icons.heart_broken_rounded),
//             Icon(Icons.add_reaction),
//             SizedBox(width: 8),
//             Text("liked by ali and 255 others"),
//             Spacer(),
//             Text("4 comments"),
//           ],
//         )
//       ],
//     );
//   }
// }
