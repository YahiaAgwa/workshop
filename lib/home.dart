import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workshop/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (cntx) => const LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  _addNewBook() {}
  String? auther, title, price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [IconButton(onPressed: _logOut, icon: const Icon(Icons.logout))],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
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
          ElevatedButton(onPressed: _addNewBook, child: const Text('Login')),
          Center(
            child: Text('hello ${FirebaseAuth.instance.currentUser!.email!}'),
          ),
        ],
      ),
    );
  }
}
