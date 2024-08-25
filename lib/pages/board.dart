// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/pages/init.dart';
import 'package:tetris/components/piece.dart';
import 'package:tetris/components/pixel.dart';
import 'package:tetris/components/values.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Timer? gameTimer;

  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  void dispose() {
    // Cancela o timer quando a página é destruída
    gameTimer?.cancel();
    super.dispose();
  }

void startGame() {
  setState(() {
    gameOver = false;
    currentScore = 0;
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (j) => null),
    );
    currentPiece.initializePiece();
    gameLoop(Duration(milliseconds: 700));
  });
}


  void gameLoop(Duration frameRate) {
    gameTimer?.cancel();

    gameTimer = Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();

        if (gameOver) {
          timer.cancel();
          showGameOverDialog();
        } else {
          acelerateGame();
          currentPiece.movePiece(Direction.down);
        }
      });
    });
  }

  void acelerateGame() {
    if (currentScore > 40) {
      gameLoop(Duration(milliseconds: 450));
    } else if (currentScore > 20) {
      gameLoop(Duration(milliseconds: 550));
    }
  }

  void pauseGame() {
    gameTimer?.cancel();
  }

  void resumeGame() {
    if (!gameOver) {
      Duration frameRate = const Duration(milliseconds: 700);
      gameLoop(frameRate);
    }
  }

  void showGameOverDialog() {
    saveScore(currentScore);
    showDialog(context: context, builder: (context) =>
      AlertDialog(
        elevation: 10,
        backgroundColor: Colors.grey[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text("Game Over", style: TextStyle(color: Colors.white)),
        content: Text("Your Score: $currentScore", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: Text("Play Again", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void showRestartGameDialog() {
    saveScore(currentScore);
    pauseGame();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        backgroundColor: Colors.grey[700],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text("Restart Game?", style: TextStyle(color: Colors.white)),
        content: Text("Current Score: $currentScore", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: Text("Restart", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              resumeGame();
              Navigator.pop(context);
            },
            child: Text("Continue", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

void showLeaveGame() {
  pauseGame();
  saveScore(currentScore);

  // Reseta o estado do jogo antes de sair
  resetGame();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text("Leave Game?", style: TextStyle(color: Colors.white)),
      content: Text("Current Score: $currentScore", style: TextStyle(color: Colors.white)),
      actions: [
        TextButton(
          onPressed: () {
            resumeGame();
            Navigator.pop(context);
          },
          child: Text("No", style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InitialPage()),
            );
          },
          child: Text("Yes", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}


  void resetGame() {
    gameTimer?.cancel();

    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (j) => null),
    );

    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  void restartGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (j) => null),
    );

    gameOver = false;
    currentScore = 0;
    createNewPiece();
    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength || (row >= 0 && gameBoard[row][col] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (checkCollision(Direction.down)) {
      gameOver = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void moveDown() {
    if (!checkCollision(Direction.down)) {
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    for (int row = colLength - 1; row >= 0; row--) {
      bool rowIsFull = true;

      for (int col = 0; col < rowLength; col++) {
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      if (rowIsFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        gameBoard[0] = List.generate(row, (index) => null);
        currentScore++;
      }
    }
  }

  void saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList('scores');

    if (scores == null) {
      scores = [];
    }

    scores.add(score.toString());
    scores.sort((a, b) => int.parse(b).compareTo(int.parse(a)));

    if (scores.length > 10) {
      scores = scores.sublist(0, 10);
    }

    await prefs.setStringList('scores', scores);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      showLeaveGame();
                    },
                    icon: Icon(Icons.arrow_back, size: 30, color: Colors.white),
                  ),
                  Text(
                    'Score: $currentScore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showRestartGameDialog();
                    },
                    icon: Icon(Icons.pause, size: 30, color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: rowLength * colLength,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength,
                  ),
                  itemBuilder: (context, index) {
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;

                    if (currentPiece.position.contains(index)) {
                      return Pixel(
                        color: currentPiece.color,
                      );
                    } else if (gameBoard[row][col] != null) {
                      final Tetromino? tetrominoType = gameBoard[row][col];
                      return Pixel(
                        color: tetrominoColors[tetrominoType],
                      );
                    } else {
                      return Pixel(
                        color: Colors.grey[900],
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: moveLeft,
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 45),
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: rotatePiece,
                          icon: Icon(Icons.rotate_right, color: Colors.white, size: 35),
                        ),
                        IconButton(
                          onPressed: moveDown,
                          icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white, size: 40),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: moveRight,
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 45),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
