/*
Name: Nur Mursyidah Binti Shahul Hameed
Matric Number: 284349
Group: A222 STIW2044 MOBILE PROGRAMMING (B)
Submitted to: Sir Ahmad Hanis Bin Mohd Shabli
Submission: Lab Assignment 1
*/

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:labexercise1_284349/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (content) => const SearchPage(title: 'Country Information App',))));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover))),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Country Information App",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),

              CircularProgressIndicator(),
                Text(
                  "Version 0.1",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
          

        ],
      ),
    );
  }
}