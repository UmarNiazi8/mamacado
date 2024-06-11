import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tenbytes/widgets/section_button.dart';

class Baby_Section extends StatefulWidget {
  const Baby_Section({super.key});

  @override
  State<Baby_Section> createState() => _Baby_SectionState();
}

class _Baby_SectionState extends State<Baby_Section> {
  int activeIndex = 0;
  final imagesUrl = [
    "https://babycarementor.com/wp-content/uploads/2017/06/newborn-care.jpeg",
    "https://img.emedihealth.com/wp-content/uploads/2021/05/tips-for-taking-care-of-a-newborn-baby-feat-1140x770.jpg",
    "https://th.bing.com/th/id/OIP.yMJr86Nh6HFwdupBprWSwQHaE7?rs=1&pid=ImgDetMain",
    "https://th.bing.com/th/id/OIP.HxtNjb1uX7sI7t73xFfuXAHaE8?w=510&h=340&rs=1&pid=ImgDetMain",
    "https://th.bing.com/th/id/OIP.a6q0SmRxgV-L_8a-bbXPgwHaEw?w=653&h=420&rs=1&pid=ImgDetMain",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: 80,
        title: const Text(
          "Baby Section",
          style: TextStyle(letterSpacing: -1),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: imagesUrl.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = imagesUrl[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                height: 230,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            buildIndicator(),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  print("Baby Care");
                },
                child: const Section_Button(
                    motherText: "Baby Care",
                    motherImage: "assets/baby_care.svg"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  print("Baby Sleep");
                },
                child: const Section_Button(
                    motherText: "Sleeping Schedule",
                    motherImage: "assets/sleep.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: const ExpandingDotsEffect(
            dotWidth: 13, dotHeight: 13, activeDotColor: Colors.white),
        activeIndex: activeIndex,
        count: imagesUrl.length,
      );

  Widget buildImage(String urlImage, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      );
}
