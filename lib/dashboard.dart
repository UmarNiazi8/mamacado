import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tenbytes/ayat_for_babyHealth/qurani_ayat_baby.dart';
import 'package:tenbytes/emergency_Call.dart';
import 'package:tenbytes/mother_section/baby_section.dart';
import 'package:tenbytes/mother_section/mother_section.dart';
import 'package:tenbytes/name_suggestion.dart';
import 'package:tenbytes/widgets/home_screen.dart';
import 'package:tenbytes/widgets/svg_image_view.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFFFEE8EA),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          toolbarHeight: 80,
          title: const Row(
            children: [
              SvgImageView(
                svgHeight: 60,
                svgWidth: 50,
                svgPath: 'assets/3.svg',
                fitType: BoxFit.fill,
                imgcolor: Colors.pink,
              ),
              Text(
                "Mama Cado",
                style: TextStyle(
                  fontFamily: 'pacifico',
                  fontSize: 22,
                  color: Colors.pink,
                ),
              ),
            ],
          ),
          // actions: <Widget>[
          //   Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: IconButton(
          //       icon: const Icon(
          //         Icons.logout_sharp,
          //         color: Colors.pink,
          //         size: 35,
          //       ),
          //       onPressed: () {
          //         _signOut(context);
          //       },
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Mother_Section()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.cyan[100],
                                borderRadius: BorderRadius.circular(20)),
                            width: 160,
                            height: 160,
                            child: const Center(
                              child: Column(
                                children: [
                                  SvgImageView(
                                      svgHeight: 80,
                                      svgWidth: 80,
                                      imgcolor: Colors.black,
                                      svgPath: "assets/motherSec.svg",
                                      fitType: BoxFit.contain),
                                  Text(
                                    'Mother \n Section',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppinsb',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Baby_Section()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.orange[200],
                                borderRadius: BorderRadius.circular(20)),
                            height: 160,
                            width: 160,
                            child: const Center(
                              child: Column(
                                children: [
                                  SvgImageView(
                                      svgHeight: 80,
                                      svgWidth: 80,
                                      imgcolor: Colors.black,
                                      svgPath: "assets/babySec.svg",
                                      fitType: BoxFit.contain),
                                  Text(
                                    'Baby \n Section',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Poppinsb',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NameSuggestion()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.orange[200],
                              borderRadius: BorderRadius.circular(20)),
                          height: 160, // Example height for the container
                          width: 160, // Example width for the container

                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              SvgImageView(
                                  svgHeight: 80,
                                  svgWidth: 80,
                                  imgcolor: Colors.black,
                                  svgPath: "assets/nameSug.svg",
                                  fitType: BoxFit.contain),
                              Text(
                                'Name \n Suggestion',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppinsb',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QurraniAyat()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.cyan[100],
                              borderRadius: BorderRadius.circular(20)),
                          height: 160, // Example height for the container
                          width: 160, // Example width for the container

                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              SvgImageView(
                                  svgHeight: 80,
                                  svgWidth: 80,
                                  imgcolor: Colors.black,
                                  svgPath: "assets/qurranAyat.svg",
                                  fitType: BoxFit.contain),
                              Text(
                                'Ayat For\nBaby Health',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Poppinsb',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(20)),
                  height: 80, // Example height for the container
                  width: 330, // Example width for the container

                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Appointment',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppinsb',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SvgImageView(
                          svgHeight: 30,
                          svgWidth: 30,
                          imgcolor: Colors.black,
                          svgPath: "assets/notification.svg",
                          fitType: BoxFit.contain),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmergencyCall()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple[200],
                        borderRadius: BorderRadius.circular(20)),
                    height: 80, // Example height for the container
                    width: 330, // Example width for the container

                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Emergency Calls',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppinsb',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SvgImageView(
                            svgHeight: 40,
                            svgWidth: 40,
                            imgcolor: Colors.black,
                            svgPath: "assets/emergencyCall.svg",
                            fitType: BoxFit.contain),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    _signOut(context);
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.pinkAccent)),
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const homeScreen()),
    );
    // Navigate back to login or home screen after logout
    // Replace '/login' with the route of your login screen
    // ignore: use_build_context_synchronously
    // Navigator.pushReplacementNamed(context, 'homeScreen()');
  } catch (e) {
    print('Error signing out: $e');
    // Handle error if any
  }
}
