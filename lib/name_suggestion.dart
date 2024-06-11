import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

class NameSuggestion extends StatefulWidget {
  const NameSuggestion({Key? key}) : super(key: key);

  @override
  State<NameSuggestion> createState() => _NameSuggestionState();
}

class _NameSuggestionState extends State<NameSuggestion> {
  final nameController = TextEditingController();
  final translationController = TextEditingController();
  final genderController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    translationController.dispose();
    genderController.dispose();
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
            "Name Suggestion",
            style: TextStyle(letterSpacing: -1),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Suggest Baby Name",
              ),
              Tab(
                text: "Saved name",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSaveBabyName(),
            _buildSuggestBabyName(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestBabyName() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('nameSuggest').snapshots(),
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
            final translation = contact['translation'];
            final gender = contact['gender'];
            final contactId = contact.id;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Card(
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
                        "Translation: $translation",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      Text(
                        "Gender: $gender",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.pink,
                    iconSize: 30,
                    onPressed: () => _deleteContact(contactId),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSaveBabyName() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/baby_name_sug.png",
              width: 400,
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Baby Name',
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
              controller: translationController,
              decoration: InputDecoration(
                hintText: 'Translation',
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
              controller: genderController,
              decoration: InputDecoration(
                hintText: 'Gender',
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
    String translation = translationController.text.trim();
    String gender = genderController.text.trim();

    if (name.isEmpty || translation.isEmpty || gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter name , translation and gender.",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
      return;
    }

    String uuid = const Uuid().v4();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('nameSuggest').doc(uuid).set({
      'userId': userId, // Associate the contact with the user's ID
      'name': name,
      'translation': translation,
      'gender': gender,
    }).then((value) {
      nameController.clear();
      translationController.clear();
      genderController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Baby Name Saved Sucessfully'),
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
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('nameSuggest')
        .doc(contactId)
        .get()
        .then((DocumentSnapshot suggestionSnapshot) {
      if (suggestionSnapshot.exists) {
        if (suggestionSnapshot['userId'] == userId) {
          FirebaseFirestore.instance
              .collection('nameSuggest')
              .doc(contactId)
              .delete()
              .then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Baby name deleted successfully'),
              ),
            );
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to delete baby name: $error'),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('You do not have permission to delete this baby name'),
            ),
          );
        }
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error retrieving baby name: $error'),
        ),
      );
    });
  }
}






// import 'package:flutter/material.dart';
// import 'package:tenbytes/data/baby_data.dart';

// class NameSuggestion extends StatelessWidget {
//   const NameSuggestion({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 1,
//         toolbarHeight: 80,
//         title: const Text(
//           "Baby Names",
//           style: TextStyle(letterSpacing: -1),
//         ),
//         automaticallyImplyLeading: true,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: babyNames.length,
//           itemBuilder: (BuildContext context, int index) {
//             final baby = babyNames[index];
//             return Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${baby.name}",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Meaning: ${baby.meaning}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Gender: ${baby.gender}",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


