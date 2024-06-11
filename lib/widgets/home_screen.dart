import 'package:flutter/material.dart';
import 'package:tenbytes/login_view.dart';
import 'package:tenbytes/signup_view.dart';
import 'package:tenbytes/widgets/svg_image_view.dart';
import 'package:tenbytes/widgets/text_view.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFEE8EA),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            const SvgImageView(
              svgHeight: 250,
              svgWidth: 200,
              svgPath: 'assets/3.svg',
              fitType: BoxFit.fill,
              imgcolor: Colors.pink,
            ),
            SizedBox(
              height: 130,
            ),
            const TextView(
              text: "Mama cado",
              fontSize: 30,
              textColor: Colors.pink,
              fontfamily: 'Pacifico',
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                fixedSize: const Size(230, 45),
                backgroundColor: Colors.pink,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins-Black",
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupView()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                fixedSize: const Size(230, 45),
                backgroundColor: Colors.pink,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                "Signup",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Poppins-Black",
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
