import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFirebaseInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(child: Text(name)),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }

  getFirebaseInfo() {
    FirebaseFirestore.instance
        .collection("dataCollection")
        .doc("dXepiBe7ilQhrJZgANRr")
        .snapshots()
        .listen((value) {
      setState(() {
        // SIEMPRE USAR
        var data = value.data();
        name = data!["name"];
      });
    });
  }
}
