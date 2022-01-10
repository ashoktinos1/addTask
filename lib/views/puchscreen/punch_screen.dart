import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';
import 'package:myproject1/views/login/login_screen.dart';

class PunchScreen extends StatefulWidget {
  const PunchScreen({Key? key}) : super(key: key);

  @override
  State<PunchScreen> createState() => _PunchScreenState();
}

class _PunchScreenState extends State<PunchScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isloading = true;
  bool puchloading = true;
  final DateTime _dateTime = DateTime.now();
  String date = DateFormat.yMMMd().format(DateTime.now());
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Text(
              "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Lets get to work", style: TextStyle(fontSize: 16)),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.work_outline),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                child: const Text(
                  "PUNCH IN",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () async {
                  setState(() {
                    isloading = false;
                  });
                  firestore
                      .collection("punching")
                      .doc(date)
                      .collection(auth.currentUser!.email.toString())
                      .doc(date)
                      .set({
                    "punchInTime":
                        "${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}",
                    "date": date
                  });
                  debugPrint(
                      "${_dateTime.hour}-${_dateTime.minute}-${_dateTime.second}");
                },
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: firestore
                .collection("belwin")
                .doc("9ZgIbiJzzr5ZyxYXnG9L")
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return isloading
                    ? const SizedBox()
                    : const Text(
                        "Successfully punched Today",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      );
              }

              return const Text("loading");
            },
          ),
          const SizedBox(
            height: 100,
          ),
          FadeInLeft(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 1000),
            child: Container(
              width: 270,
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                child: const Text("PUNCH OUT",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  setState(() {
                    puchloading = false;
                  });
                  firestore
                      .collection("punching")
                      .doc(date)
                      .collection(auth.currentUser!.email.toString())
                      .doc(date)
                      .update({
                    "punchOutTime":
                        "${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}",
                  });

                  print(
                      "${_dateTime.hour}-${_dateTime.minute}-${_dateTime.second}");
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          puchloading
              ? const SizedBox()
              : const Text("Succesfully punched Out",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          MaterialButton(
            onPressed: () async {
              try {
                await auth.signOut();
                print("object");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => true);
              } catch (e) {
                print(e.toString());
              }
            },
            height: 45,
            color: Colors.black,
            child: const Text(
              "logout",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ],
      ),
    );
  }
}
