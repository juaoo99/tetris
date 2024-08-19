// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tetris/board.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

goTo(){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => GameBoard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             GestureDetector(
              child: Text("Play Now", style: TextStyle(color: Colors.white, fontSize: 35),),
                onTap: goTo,
                //child: Lottie.asset('assets/play.json', width: 150),
                ),
            ],
          ),
        ),
      ),
      Align(
            alignment: Alignment.bottomCenter,
            child: Lottie.asset(
              'assets/animation.json',
              width: double.infinity,
              height: 250, // Ajuste a altura conforme necessário
              fit: BoxFit.cover,
            ),
          ),
      ],)
    );
  }
}