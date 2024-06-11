// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgImageButton extends StatelessWidget {
  final double svgHeight;
  final double svgWidth;
  final String svgPath;
  final Color? imgColor;

  const SvgImageButton({
    Key? key,
    required this.svgHeight,
    required this.svgWidth,
    required this.svgPath,
    this.imgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      width: svgWidth,
      height: svgHeight,
    );
  }
}
