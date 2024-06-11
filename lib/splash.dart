import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tenbytes/widgets/home_screen.dart';
import 'package:tenbytes/widgets/svg_image_view.dart';

import 'widgets/widgets.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    load(context);
    super.initState();
  }

  load(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => homeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: const Color(0XFFFFEE8EA),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgImageView(
                svgHeight: 160,
                svgWidth: 160,
                svgPath: 'assets/3.svg',
                fitType: BoxFit.fill,
                imgcolor: Colors.pink,
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                text: "Mama Cado",
                fontfamily: 'pacifico',
                fontSize: 30,
                textColor: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
