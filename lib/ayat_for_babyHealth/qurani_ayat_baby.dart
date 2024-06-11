import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

class QurraniAyat extends StatefulWidget {
  const QurraniAyat({Key? key}) : super(key: key);

  @override
  State<QurraniAyat> createState() => _QurraniAyatState();
}

class _QurraniAyatState extends State<QurraniAyat> {
  final nameController = TextEditingController();
  final verseController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    verseController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          toolbarHeight: 80,
          title: const Text(
            "Qurran Verses",
            style: TextStyle(letterSpacing: -1),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Verses",
              ),
              Tab(
                text: "Saved Verses",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildVerseSaveTab(),
            _buildViewVerseTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildViewVerseTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('QurraniAyat')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final contacts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            final name = contact['name'];
            final verse = contact['verse'];

            final contactId = contact.id;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Stack(
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      title: Text(
                        name,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            "$verse",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned widget on top of the card
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.pink,
                      iconSize: 30,
                      onPressed: () => _deleteContact(contactId),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildVerseSaveTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/qurrani_ayat.png",
              width: 400,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Surah or Verse Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.text,
              controller: verseController,
              decoration: InputDecoration(
                hintText: 'Enter Surah or verse',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveContact,
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    String name = nameController.text.trim();

    String verse = verseController.text.trim();

    if (name.isEmpty || verse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter Name and enter arabic .",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
      return;
    }

    String uuid = const Uuid().v4();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('QurraniAyat').doc(uuid).set({
      'userId': userId, // Associate the contact with the user's ID
      'name': name,
      'verse': verse,
    }).then((value) {
      nameController.clear();
      verseController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Qurrani Ayat saved Sucessfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save : $error'),
        ),
      );
    });
  }

  void _deleteContact(String contactId) {
    FirebaseFirestore.instance
        .collection('QurraniAyat')
        .doc(contactId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Qurrani ayat deleted successfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete contact: $error'),
        ),
      );
    });
  }
}









// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class QurraniAyat extends StatefulWidget {
//   const QurraniAyat({Key? key}) : super(key: key);

//   @override
//   State<QurraniAyat> createState() => _QurraniAyatState();
// }

// class _QurraniAyatState extends State<QurraniAyat> {
//   final ayatController = TextEditingController();

//   @override
//   void dispose() {
//     ayatController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         toolbarHeight: 80,
//         title: const Text(
//           "Qurran Verses",
//           style: TextStyle(letterSpacing: -1),
//         ),
//         automaticallyImplyLeading: true,
//         centerTitle: true,
//       ),
//       body: Material(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const AyatContainer(
//                 title: 'Ayat al-Kursi',
//                 arabicText:
//                     'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ...',
//                 translation: 'Allah - there is no deity except Him...',
//               ),
//               const SizedBox(height: 20),
//               const AyatContainer(
//                 title: 'Sura-e-Fatiha',
//                 arabicText: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n...',
//                 translation: '',
//                 // Add Arabic and translation text here
//               ),
//               const SizedBox(height: 20),
//               const AyatContainer(
//                 title: 'Surah-e-Rehman',
//                 arabicText: 'الرَّحْمَٰنُ\nالَّذِي عَلَّمَ الْقُرْآنَ\n...',
//                 translation: '',
//                 // Add Arabic and translation text here
//               ),
//               const SizedBox(height: 20),
//               const AyatContainer(
//                 title: 'Surah-e-Ikhlas',
//                 arabicText: 'قُلْ هُوَ اللَّهُ أَحَدٌ\nاللَّهُ الصَّمَدُ\n...',
//                 translation: '',
//                 // Add Arabic and translation text here
//               ),
//               const SizedBox(height: 20),
//               const AyatContainer(
//                 title: 'Surah-e-Naas',
//                 arabicText:
//                     'قُلْ أَعُوذُ بِرَبِّ النَّاسِ\nمَلِكِ النَّاسِ\n...',
//                 translation: '',
//                 // Add Arabic and translation text here
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.blue,
//                     width: 2.0,
//                   ),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Add New Ayat:',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: ayatController,
//                       decoration: const InputDecoration(
//                         hintText: 'Enter Ayat',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _saveAyat,
//                       child: const Text("Save"),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _saveAyat() {
//     String text = ayatController.text.trim();

//     // Check if Ayat text is not empty
//     if (text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please enter Ayat.",
//             style: TextStyle(color: Colors.red, fontSize: 16),
//           ),
//         ),
//       );
//       return;
//     }

//     // Generate a UUID
//     String uuid = const Uuid().v4();

//     // Save data to Firestore with UUID as the document ID
//     FirebaseFirestore.instance.collection('ayat').doc(uuid).set({
//       'text': text,
//     }).then((value) {
//       ayatController.clear();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Ayat saved successfully'),
//         ),
//       );
//     }).catchError((error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to save Ayat: $error'),
//         ),
//       );
//     });
//   }
// }

// class AyatContainer extends StatelessWidget {
//   final String title;
//   final String arabicText;
//   final String translation;

//   const AyatContainer({
//     Key? key,
//     required this.title,
//     required this.arabicText,
//     required this.translation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 500,
//       padding: const EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.blue,
//           width: 2.0,
//         ),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             arabicText,
//             style: const TextStyle(fontSize: 20),
//             textAlign: TextAlign.right,
//           ),
//           const SizedBox(height: 10),
//           const Text(
//             'Translation:',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             translation,
//             style: const TextStyle(fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }
// }


// // import 'package:flutter/material.dart';

// // class QuranApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Ayat al-Kursi',
// //       home: QuranPage(),
// //     );
// //   }
// // }

// // class QuranPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0XFFFFEE8EA),
// //       appBar: AppBar(
// //         title: Text('Ayat al-Kursi'),
// //       ),
//       // body: SingleChildScrollView(
//       //   padding: EdgeInsets.all(20.0),
//       //   child: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: [
//       //       Container(
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Ayat al-Kursi',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ',
//       //               style: TextStyle(fontSize: 20),
//       //               textAlign: TextAlign.right,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(height: 20),
//       //       Container(
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Translation:',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
//       //               style: TextStyle(fontSize: 16),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         height: 10,
//       //       ),
//       //       Container(
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Sura-e_Fatiha',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ\n'
//       //               'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ\n'
//       //               'الرَّحْمَٰنِ الرَّحِيمِ\n'
//       //               'مَالِكِ يَوْمِ الدِّينِ\n'
//       //               'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\n'
//       //               'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ\n'
//       //               'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
//       //               style: TextStyle(fontSize: 20),
//       //               textAlign: TextAlign.right,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(height: 20),
//       //       Container(
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Translation:',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'In the name of Allah, the Entirely Merciful, the Especially Merciful.\n'
//       //               'Praise be to Allah, the Lord of all the worlds.\n'
//       //               'The Entirely Merciful, the Especially Merciful.\n'
//       //               'Master of the Day of Judgment.\n'
//       //               'You alone we worship, and You alone we ask for help.\n'
//       //               'Guide us on the Straight Path,\n'
//       //               'the path of those who have received Your grace; not the path of those who have brought down wrath upon themselves, nor of those who have gone astray.',
//       //               style: TextStyle(fontSize: 16),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       Container(
//       //         width: 500,
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Surah-e-Rehman',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'الرَّحْمَٰنُ\n'
//       //               'الَّذِي عَلَّمَ الْقُرْآنَ\n'
//       //               'خَلَقَ الْإِنسَانَ\n'
//       //               'عَلَّمَهُ الْبَيَانَ\n'
//       //               'الشَّمْسُ وَالْقَمَرُ بِحُسْبَانٍ\n'
//       //               'وَالنَّجْمُ وَالشَّجَرُ يَسْجُدَانِ\n'
//       //               'وَالسَّمَاءَ رَفَعَهَا وَوَضَعَ الْمِيزَانَ\n'
//       //               'أَلَّا تَطْغَوْا فِي الْمِيزَانِ\n'
//       //               'وَأَقِيمُوا الْوَزْنَ بِالْقِسْطِ وَلَا تُخْسِرُوا الْمِيزَانَ\n'
//       //               'وَالْأَرْضَ وَضَعَهَا لِلْأَنَامِ\n'
//       //               'فِيهَا فَاكِهَةٌ وَالنَّخْلُ ذَاتُ الْأَكْمَامِ\n'
//       //               'وَالْحَبُّ ذُو الْعَصْفِ وَالرَّيْحَانُ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'خَلَقَ الْإِنسَانَ مِن صَلْصَالٍ كَالْفَخَّارِ\n'
//       //               'وَخَلَقَ الْجَانَّ مِن مَّارِجٍ مِّن نَّارٍ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'رَبُّ الْمَشْرِقَيْنِ وَرَبُّ الْمَغْرِبَيْنِ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'مَرَجَ الْبَحْرَيْنِ يَلْتَقِيَانِ\n'
//       //               'بَيْنَهُمَا بَرْزَخٌ لَّا يَبْغِيَانِ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'يَخْرُجُ مِنْهُمَا اللُّؤْلُؤُ وَالْمَرْجَانُ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'وَلَهُ الْجَوَارِ الْمُنشَآتُ فِي الْبَحْرِ كَالْأَعْلَامِ\n'
//       //               'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ\n'
//       //               'كُلُّ مَنْ عَلَيْهَا فَانٍ\n'
//       //               'وَيَبْقَىٰ وَجْهُ رَبِّكَ ذُو الْجَلَالِ وَالْإِكْرَامِ\n'
//       //               'فَب',
//       //               style: TextStyle(fontSize: 20),
//       //               textAlign: TextAlign.right,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(height: 20),
//       //       Container(
//       //         width: 500,
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Translation:',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'Allah - there is no deity except Him, the Ever-Living, the Sustainer of [all] existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth. Who is it that can intercede with Him except by His permission? He knows what is [presently] before them and what will be after them, and they encompass not a thing of His knowledge except for what He wills. His Kursi extends over the heavens and the earth, and their preservation tires Him not. And He is the Most High, the Most Great.',
//       //               style: TextStyle(fontSize: 16),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         height: 20,
//       //       ),
//       //       Container(
//       //         width: 500,
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'surah-e-Ikhlas',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'قُلْ هُوَ اللَّهُ أَحَدٌ\n'
//       //               'اللَّهُ الصَّمَدُ\n'
//       //               'لَمْ يَلِدْ وَلَمْ يُولَدْ\n'
//       //               'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
//       //               textAlign: TextAlign.right,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(height: 20),
//       //       Container(
//       //         width: 500,
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Translation:',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'Say, "He is Allah, [who is] One,\n'
//       //               'Allah, the Eternal Refuge.\n'
//       //               'He neither begets nor is born,\n'
//       //               'Nor is there to Him any equivalent."',
//       //               style: TextStyle(fontSize: 16),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       Container(
//       //         width: 500,
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Surah-e-naas',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'قُلْ أَعُوذُ بِرَبِّ النَّاسِ\n'
//       //               'مَلِكِ النَّاسِ\n'
//       //               'إِلَٰهِ النَّاسِ\n'
//       //               'مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ\n'
//       //               'الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ\n'
//       //               'مِنَ الْجِنَّةِ وَالنَّاسِ',
//       //               style: TextStyle(fontSize: 20),
//       //               textAlign: TextAlign.right,
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //       SizedBox(height: 20),
//       //       Container(
//       //         padding: EdgeInsets.all(10.0),
//       //         decoration: BoxDecoration(
//       //           border: Border.all(
//       //             color: Colors.blue,
//       //             width: 2.0,
//       //           ),
//       //           borderRadius: BorderRadius.circular(10.0),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Translation:',
//       //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       //             ),
//       //             SizedBox(height: 10),
//       //             Text(
//       //               'Say, "I seek refuge in the Lord of mankind,\n'
//       //               'The Sovereign of mankind,\n'
//       //               'The God of mankind,\n'
//       //               'From the evil of the whisperer (devil who whispers evil in the hearts of men) who withdraws (from his whispering in one\'s heart after one remembers Allah),\n'
//       //               'Who whispers in the breasts of mankind,\n'
//       //               'Of jinn and men."',
//       //               style: TextStyle(fontSize: 16),
//       //             ),
//       //           ],
//       //         ),
//       //       ),
//       //     ],
//       //   ),
// //       ),
// //     );
// //   }
// // }
