// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  List<int> topScores = [];

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  Future<void> loadScores() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList('scores');

    if (scores != null) {
      setState(() {
        topScores = scores.map((score) => int.parse(score)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Top 10 Scores', style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ListView.builder(
                        itemCount: topScores.length,
                        itemBuilder: (context, index) {
             return ListTile(
               leading: Text('${index + 1}.', style: TextStyle(color: Colors.white, fontSize: 20),),
               title: Text('Score: ${topScores[index]}',  style: TextStyle(color: Colors.white, fontSize: 20)),
             );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
