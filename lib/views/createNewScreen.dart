import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class createNotesScreen extends StatefulWidget {
  const createNotesScreen({Key? key}) : super(key: key);

  @override
  State<createNotesScreen> createState() => _createNotesScreenState();
}

class _createNotesScreenState extends State<createNotesScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Note"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: InputDecoration(hintText: "Add Note"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.toString().trim();
                  if (note != " ") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes") // for collection
                          .doc() // for document
                          .set({   // set value
                        "createdAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid,
                      });
                    } catch (e) {
                      print("Error $e");
                    }
                  }
                },
                child: Text("Add Note"))
          ],
        ),
      ),
    );
  }
}
