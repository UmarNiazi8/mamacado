import 'package:flutter/material.dart';
import 'package:tenbytes/widgets/svg_img_button.dart';

class Section_Button extends StatelessWidget {
  final String motherText;
  final String motherImage;

  const Section_Button({
    super.key,
    required this.motherText,
    required this.motherImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      width: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgImageButton(
                  svgHeight: 100,
                  svgWidth: 100,
                  svgPath: motherImage,
                ),
                Text(
                  motherText,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
