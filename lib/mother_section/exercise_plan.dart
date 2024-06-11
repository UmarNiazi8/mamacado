import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:link_preview_generator/link_preview_generator.dart';
import 'package:tenbytes/widgets/video_player.dart';

class Exercise_Plan extends StatefulWidget {
  const Exercise_Plan({super.key});

  @override
  State<Exercise_Plan> createState() => _Exercise_PlanState();
}

class _Exercise_PlanState extends State<Exercise_Plan> {
  List<String> videoURL = [
    "https://youtu.be/iZYew0NEe24?si=6QUBVVEL6QN9RygD",
    "https://youtu.be/aCx0Pgb8X0Q?si=y80fcwop5IlP4MUr",
    "https://youtu.be/4euiCrgResg?si=Yjf3t4Y5sn6LYNFI",
    "https://youtu.be/VhRNqtsFyKQ?si=kxMEurvT4u1LJ9yI",
    "https://youtu.be/OSPbKphT5T8?si=SwEZroPf_uRW8_i3",
    "https://youtu.be/n2KWvIhWjmo?si=LzhpcSrU2bnl18k-",
    "https://youtu.be/lKx0sOz31C4?si=2PzbJMt9d7JmKiAS",
    "https://youtu.be/1vjezAe_oCs?si=9mGmrvc_hdjK636A",
    "https://youtu.be/Mjt3jYJm3pc?si=_0C-3w4V5zsTzS5P",
    "https://youtu.be/ZGQ7VqRODmI?si=wUn4-vnPz4x6goq6",
    "https://youtu.be/Wsq03gU73gQ?si=G5ddPx7IQJAAEGY2",
    "https://youtu.be/b-X-kr3JUOQ?si=Aan0ojnbmzBTy1g7",
    "https://youtu.be/PiSp9fnekZc?si=YcYYeX6jgaxUmyCU",
    "https://youtu.be/KpGt-9RjKOo?si=ZfFPvwD0KzIOtQiu",
    "https://youtu.be/AQA_PMsVHBo?si=8wMkUR6O3ypuRupD",
    "https://youtu.be/Y4u7yE_adKA?si=uGQPt9y-nhrpAu6Q",
    "https://youtu.be/9Xwl5oHS98Q?si=DkpwDgzpYA-X0Icb",
    "https://youtu.be/X_ppjiLarrg?si=-S_ZM-3IzBScLw0t",
    "https://youtu.be/0NRadDfQR6Q?si=-eolim0pcc4Rmvaw",
  ];

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          toolbarHeight: 80,
          title: const Text(
            "Exercise Plan",
            style: TextStyle(letterSpacing: -1),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: videoURL.length,
              padding: EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 30, right: 10, left: 10),
                  child: LinkPreviewGenerator(
                    graphicFit: BoxFit.fill,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayer(
                              url: videoURL[index],
                            ),
                          ));
                    },
                    bodyMaxLines: 1,
                    link: videoURL[index],
                    linkPreviewStyle: LinkPreviewStyle.large,
                    showGraphic: true,
                  ),
                );
              }),
        ));
  }
}
