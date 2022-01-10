import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class LeaveScreen extends StatefulWidget {
  LeaveScreen(
      {Key? key,
      required this.leavetypes,
      required this.typeofleaves,
      required this.dates})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  var leavetypes;

  // ignore: prefer_typing_uninitialized_variables
  var typeofleaves;
  // ignore: prefer_typing_uninitialized_variables
  var dates;

  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  bool isapplied = true;
  CollectionReference users = FirebaseFirestore.instance.collection('jithin');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'leavetype': widget.leavetypes, // John Doe
          'typeofleave': widget.typeofleaves, // Stokes and Sons
          'date': widget.dates // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  DateTime? date;
  String getText() {
    if (date == null) {
      return "Select Date";
    } else {
      return DateFormat("dd/MM/yyyy").format(date!);
    }
  }

  pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() {
      date = newDate;
      widget.dates = newDate;
    });
  }

  final _leavetype = ["Half Day", "Full Day"];
  final _casualmedical = ["Casual Leave", "Medical Leave"];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonFormField(

              // dropdownColor: Colors.blue,
              hint: const Text("Leave type"),
              onChanged: (value) {
                widget.leavetypes = value;
              },
              items: _leavetype.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList()),

          DropdownButtonFormField(
              hint: const Text("Casual/Medical"),
              onChanged: (value) {
                widget.typeofleaves = value;
              },
              items: _casualmedical.map((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList()),

          // DropdownButtonFormField(
          //   hint: const Text("Leave day"),
          //   onChanged: (value){
          //     print(value);

          //   },
          //     items: _days.map((e) {
          //   return DropdownMenuItem(

          //     value: e,
          //     child: Text(e));
          // }).toList()),

          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                pickDate(context);
              },
              child: Text(getText()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          Container(
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black, blurRadius: 2, offset: Offset(0, 1))
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child: isapplied
                  ? SizedBox(
                      height: 50,
                      child: TextButton(
                        child: const Text(
                          "Apply Leave",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isapplied = false;
                          });
                          addUser();
                        },
                      ),
                    )
                  : SizedBox(
                      height: 50,
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 50,
                      )))
        ],
      ),
    ));
  }
}
