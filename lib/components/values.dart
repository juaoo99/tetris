
  //grid dimentions
  import 'dart:ui';

import 'package:flutter/material.dart';

int rowLength = 10;
  int colLength = 15;

  enum Direction {
    right,
    left,
    down
  }

  enum Tetromino {
    L,
    J,
    I,
    O,
    S,
    Z,
    T
  }

  const Map<Tetromino, Color> tetrominoColors = {
    Tetromino.J: Color(0xFFFF5500),
    Tetromino.L: Color(0xFFFF0000),
    Tetromino.I: Color(0xFFFFD500),
    Tetromino.S: Color(0xff00ff040),
    Tetromino.O: Color(0xFF00E5FF),
    Tetromino.Z: Color(0xFF0D00FF),
    Tetromino.T: Color(0xFF7700FF),
  };