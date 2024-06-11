import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tenbytes/widgets/svg_img_button.dart';

class Baby_Kick_Count extends StatefulWidget {
  const Baby_Kick_Count({super.key});

  @override
  State<Baby_Kick_Count> createState() => _Baby_Kick_CountState();
}

class _Baby_Kick_CountState extends State<Baby_Kick_Count> {
  double number = 0;
  double circularPercent = 0.001;
  double linearPercent = 0.01;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Load kick count for the current user when the widget initializes
    loadKickCount();
  }

  void loadKickCount() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Retrieve kick count for the current user from Firestore
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('kick_Count').doc(user.uid).get();
      setState(() {
        number = (doc.exists) ? doc.data()!['number'] ?? 0 : 0;
        updatePercent();
      });
    }
  }

  void updatePercent() {
    setState(() {
      circularPercent = (number * 0.01).clamp(0.0, 1.0);
      linearPercent = (number * 0.01).clamp(0.0, 1.0);
    });
  }

  Future<void> kicksAdded(double number) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('kick_Count').doc(user.uid).set({
          'number': number,
        });
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "Baby Kick Count",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/baby_kicks.png",
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 40,
          ),
          CircularPercentIndicator(
            radius: 100,
            lineWidth: 20,
            backgroundColor: Colors.pink,
            progressColor: Colors.yellow,
            percent: circularPercent,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SvgImageButton(
                    svgHeight: 60,
                    svgWidth: 60,
                    svgPath: "assets/baby_kick.svg"),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  number.toInt().toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            //animationDuration: 3000,
            onAnimationEnd: () {
              print("Animation End");
            },
            //header: const Text("Kicks Counted"),
          ),
          const SizedBox(
            height: 30,
          ),
          LinearPercentIndicator(
            width: 200,
            lineHeight: 20,
            backgroundColor: Colors.pink,
            progressColor: Colors.yellow,
            percent: linearPercent,
            animation: true,
            animationDuration: 2000,
            alignment: MainAxisAlignment.center,
            barRadius: const Radius.circular(10),
            leading: ClipOval(
              child: Material(
                color: Colors.blue, // Button color
                child: InkWell(
                  splashColor: Colors.pink, // Splash color
                  onTap: () {
                    setState(() {
                      number--;
                      updatePercent();
                      kicksAdded(number);
                      //kicksAdded(number); // Update Firestore
                    });
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
            trailing: ClipOval(
              child: Material(
                color: Colors.grey, // Button color
                child: InkWell(
                  splashColor: Colors.pink, // Splash color
                  onTap: () {
                    setState(() {
                      number++;
                      updatePercent();
                      kicksAdded(number);
                      //kicksAdded(number); // Update Firestore
                    });
                  },
                  child: const SizedBox(
                    width: 30,
                    height: 30,
                    child: Icon(
                      Icons.add,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
