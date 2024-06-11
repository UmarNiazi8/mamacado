import 'package:flutter/material.dart';
import 'package:tenbytes/mother_section/baby_kick_count.dart';
import 'package:tenbytes/mother_section/exercise_plan.dart';
import 'package:tenbytes/mother_section/pragrency_tracking.dart';
import 'package:tenbytes/widgets/section_button.dart';

class Mother_Section extends StatelessWidget {
  const Mother_Section({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "Mother Section",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PregnancyTrackerPage()),
                );
              },
              child: const Section_Button(
                motherImage: "assets/pregnent_woman.svg",
                motherText: "Pregnant Tracking",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Baby_Kick_Count()),
                );
              },
              child: const Section_Button(
                  motherText: "Baby Kick Count",
                  motherImage: "assets/baby_kick.svg"),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Exercise_Plan()),
                );
              },
              child: const Section_Button(
                  motherText: "Exercise Plan",
                  motherImage: "assets/exercise.svg"),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: const Section_Button(
                  motherText: "Health Care Tips",
                  motherImage: "assets/tips.svg"),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {},
              child: const Section_Button(
                  motherText: "Baby Bag", motherImage: "assets/baby_bag.svg"),
            )
          ],
        ),
      ),
    );
  }
}
