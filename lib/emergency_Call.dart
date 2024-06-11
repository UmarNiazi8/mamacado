import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class EmergencyCall extends StatefulWidget {
  const EmergencyCall({Key? key}) : super(key: key);

  @override
  State<EmergencyCall> createState() => _EmergencyCallState();
}

class _EmergencyCallState extends State<EmergencyCall> {
  final nameController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneNoController.dispose();
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
            "Emergency Call",
            style: TextStyle(letterSpacing: -1),
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "View Contacts",
              ),
              Tab(
                text: "Save Contact",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildSaveContactTab(),
            _buildViewContactsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildViewContactsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('contacts')
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
            final phone = contact['phone'];
            final contactId = contact.id;
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.pink, // Border color
                    width: 1, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Border radius
                ),
                child: ListTile(
                  title: Text(
                    name,
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  subtitle: Text(
                    phone,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
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

  Widget _buildSaveContactTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset(
              "assets/emergency_call.png",
              width: 500,
              height: 200,
              fit: BoxFit.cover,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: phoneNoController,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveContact,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() {
    String name = nameController.text.trim();
    String phone = phoneNoController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter both name and phone number.",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
      return;
    }

    if (phone.length != 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid 11-digit phone number.",
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
      return;
    }

    String uuid = const Uuid().v4();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('contacts').doc(uuid).set({
      'userId': userId, // Associate the contact with the user's ID
      'name': name,
      'phone': phone,
    }).then((value) {
      nameController.clear();
      phoneNoController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact saved successfully'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save contact: $error'),
        ),
      );
    });
  }

  void _deleteContact(String contactId) {
    FirebaseFirestore.instance
        .collection('contacts')
        .doc(contactId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Contact deleted successfully'),
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
