// // ignore: depend_on_referenced_packages

// import 'package:flutter/material.dart';
// import 'package:tenbytes/widgets/svg_image_view.dart';

// class AuthCircle extends StatelessWidget {
//   final double boxHeight;
//   final double boxWidth;
//   final Color boxColor;
//   final String svgPath;
//   final double circlepadding;
//   const AuthCircle(
//       {super.key,
//       required this.boxHeight,
//       required this.boxWidth,
//       this.circlepadding = 18,
//       required this.boxColor,
//       required this.svgPath});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: boxHeight,
//       width: boxWidth,
//       padding: EdgeInsets.all(circlepadding),
//       decoration: BoxDecoration(
//         color: boxColor,
//         shape: BoxShape.circle,
//       ),
//       child: FittedBox(
//         child: SvgImageView(
//           svgHeight: 500,
//           svgWidth: 55,
//           svgPath: svgPath,
//           fitType: BoxFit.cover,
//           imgcolor: Colors.transparent,
//         ),
//       ),
//     );
//   }
// }
