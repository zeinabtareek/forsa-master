import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fursa/Core/Styles/Colors.dart';
import 'package:fursa/View/SharedComponents/ContainerStyles.dart';

class BindingScreen extends StatefulWidget {
  BindingScreen({Key key}) : super(key: key);

  @override
  State<BindingScreen> createState() => _BindingScreenState();
}

class _BindingScreenState extends State<BindingScreen> {
  bool loader = false;
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: color1,
            centerTitle: true,
            title: Text('Binding'),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipOval(
                  child: Image.asset(
                    'images/whatch2.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Apple watch G2',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  width: media.width,
                  height: 50,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: standaredBoxShadow),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                          hintText: "Amount",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                Container(
                  width: media.width,
                  height: 50,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: buttonColor1),
                  child: Center(
                      child: Text(
                    'Binging Now',
                    style: TextStyle(color: Colors.white),
                  )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
