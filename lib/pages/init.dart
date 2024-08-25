// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tetris/pages/board.dart';
import 'package:tetris/pages/score.dart';

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

scorePage(){
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => ScorePage()));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: scorePage, icon: Icon(Icons.score_sharp, size: 50, color: Colors.white,)),
                  ],
                ),
              ),
             GestureDetector(
              child: Text("Play Now", style: TextStyle(color: Colors.white, fontSize: 35),),
                onTap: goTo,
                //child: Lottie.asset('assets/play.json', width: 150),
                ),
                SizedBox(height:80,),
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