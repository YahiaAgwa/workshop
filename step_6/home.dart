import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workshop/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (cntx) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  _addNewBook() async {
    DocumentReference<Map<String, dynamic>> book = await firestore.collection('books').add({
      "auther": auther,
      "title": title,
      "price": price,
      "createdBy": FirebaseAuth.instance.currentUser!.uid,
      "createdAt": FieldValue.serverTimestamp()
    });
    await book.update({"id": book.id});
    setState(() => showAddForm = false);
  }

  String? auther, title, price;
  bool showAddForm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: () => setState(() => showAddForm = !showAddForm), icon: const Icon(Icons.add)),
          IconButton(onPressed: _logOut, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (showAddForm) ...[
              TextFormField(
                onChanged: (value) => title = value,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => auther = value,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Auther',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) => price = value,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Price',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: _addNewBook, child: const Text('Create')),
            ],
            Center(
              child: Text('hello ${FirebaseAuth.instance.currentUser!.email!}'),
            ),
          ],
        ),
      ),
    );
  }
}
