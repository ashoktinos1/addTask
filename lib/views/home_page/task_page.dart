import 'package:flutter/material.dart';

import 'package:myproject1/views/home_page/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      // backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
        child: CategoryWidget(
          itemHeight: itemHeight,
          itemWidth: itemWidth,
        ),
      ),
    );
  }
}
