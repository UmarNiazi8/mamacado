// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageView extends StatelessWidget {
  final double svgHeight;
  final double svgWidth;
  final String svgPath;
  final BoxFit fitType;
  final Color imgcolor;
  const SvgImageView({
    super.key,
    required this.svgHeight,
    required this.svgWidth,
    required this.svgPath,
    required this.fitType,
    required this.imgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      color: imgcolor,
      fit: fitType,
      svgPath,
      width: svgWidth,
      height: svgHeight,
    );
  }
}
