import 'dart:ui';

import 'package:tetris/board.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position =[];

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26, -16, -6, -5
        ];
        break;
        case Tetromino.J:
        position = [
          -25, -15, -5, -6
        ];
        break;
        case Tetromino.I:
        position = [
          -4, -5, -6, -7
        ];
        break;
        case Tetromino.Z:
        position = [
          -17, -16, -6, -5
        ];
        break;
        case Tetromino.S:
        position = [
          -15, -14, -6, -5
        ];
        break;
        case Tetromino.O:
        position = [
          -15, -16, -5, -6
        ];
        break;
        case Tetromino.T:
        position = [
          -26, -16, -6, -15
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch(direction){
      case Direction.down:
        for(int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
              case Direction.left:
        for(int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
              case Direction.right:
        for(int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate
  int rotateState = 1;
  void rotatePiece(){
    List<int> newPosition = [];
    switch (type) {
      case Tetromino.L:
      switch(rotateState){
        case 0:
          newPosition = [
            position[1] - rowLength,
            position[1],
            position[1] + rowLength,
            position[1] + rowLength + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
          case 1:
            newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + rowLength - 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }

          break;

          case 2:
            newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] - rowLength - 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;

          case 3:
          newPosition = [
            position[1] - rowLength + 1,
            position[1],
            position[1] + 1,
            position[1] - 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }
      break;
            case Tetromino.I:
      switch(rotateState){
        case 0:
          newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + 2
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
          case 1:
            newPosition = [
            position[1] - rowLength,
            position[1],
            position[1] + rowLength,
            position[1] + 2 * rowLength
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }

          break;

          case 2:
            newPosition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] - 2
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;

          case 3:
          newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] - 2 * rowLength
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }
      break;

    case Tetromino.J:
      switch(rotateState){
        case 0:
          newPosition = [
            position[1] - rowLength,
            position[1],
            position[1] + rowLength,
            position[1] + rowLength - 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
          case 1:
            newPosition = [
            position[1] - rowLength -1,
            position[1],
            position[1] - 1,
            position[1] + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }

          break;

          case 2:
            newPosition = [
            position[1] + rowLength,
            position[1],
            position[1] - rowLength,
            position[1] - rowLength + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;

          case 3:
          newPosition = [
            position[1] + 1,
            position[1],
            position[1] - 1,
            position[1] + rowLength + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }
      break;

      case Tetromino.O:

      break;

case Tetromino.S:
  switch(rotateState) {

    case 0: // Estado inicial
      newPosition = [
        position[1],                       // Posição central
        position[1] + 1,                   // Direita
        position[1] + rowLength - 1,       // Abaixo-esquerda
        position[1] + rowLength            // Abaixo
      ];
      if(piecePositionIsValid(newPosition)) {
        position = newPosition;
        rotateState = (rotateState + 1) % 4;
      }
      break;

    case 1: // 90 graus
      newPosition = [
        position[0] - rowLength,           // Acima
        position[0],                       // Posição central
        position[0] + 1,                   // Direita
        position[0] + rowLength + 1        // Abaixo-direita
      ];
      if(piecePositionIsValid(newPosition)) {
        position = newPosition;
        rotateState = (rotateState + 1) % 4;
      }
      break;

    case 2: // 180 graus (espelho do estado inicial)
      newPosition = [
        position[1],                       // Posição central
        position[1] + 1,                   // Direita
        position[1] + rowLength + 1,       // Abaixo-direita
        position[1] + rowLength            // Abaixo
      ];
      if(piecePositionIsValid(newPosition)) {
        position = newPosition;
        rotateState = (rotateState + 1) % 4;
      }
      break;

    case 3: // 270 graus (espelho do estado 90 graus)
      newPosition = [
        position[0] - rowLength,           // Acima
        position[0],                       // Posição central
        position[0] - 1,                   // Esquerda
        position[0] + rowLength - 1        // Abaixo-esquerda
      ];
      if(piecePositionIsValid(newPosition)) {
        position = newPosition;
        rotateState = (rotateState + 1) % 4;
      }
      break;
  }
  break;

    case Tetromino.Z:
      switch(rotateState){
        case 0:
          newPosition = [
            position[0] + rowLength - 2,
            position[1],
            position[2] + rowLength - 1,
            position[3] + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
          case 1:
            newPosition = [
            position[0] - rowLength + 2,
            position[1],
            position[2] - rowLength + 1,
            position[3] -1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }

          break;

          case 2:
            newPosition = [
            position[0] + rowLength - 2,
            position[1],
            position[2] + rowLength - 1,
            position[3] + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;

          case 3:
          newPosition = [
            position[0] - rowLength + 2,
            position[1],
            position[2] - rowLength + 1 ,
            position[3] - 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }

          case Tetromino.T:
      switch(rotateState){
        case 0:
          newPosition = [
            position[2] - rowLength,
            position[2],
            position[2] + 1,
            position[2] + rowLength
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
          case 1:
            newPosition = [
            position[1] - 1,
            position[1],
            position[1] + 1,
            position[1] + rowLength
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }

          break;

          case 2:
            newPosition = [
            position[1] - rowLength,
            position[1] - 1,
            position[1],
            position[1] + rowLength
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;

          case 3:
          newPosition = [
            position[2] - rowLength,
            position[2] - 1,
            position[2],
            position[2] + 1
          ];
          if(piecePositionIsValid(newPosition)){
            position = newPosition;
            rotateState = (rotateState + 1) % 4;
          }
          break;
      }
      break;
    default:
  }
}

  bool positionIsValid(int position) {
    int  row = (position / rowLength).floor();
    int col = position % rowLength;

    if(row < 0 || col < 0 || gameBoard[row][col] != null){
      return false;
    }
    else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for(int pos in piecePosition){
      if(!positionIsValid(pos)){
        return false;
      }

    int col = pos % rowLength;

    if(col ==0){
      firstColOccupied = true;
    }
    if(col == rowLength - 1) {
      lastColOccupied = true;
    }
    }

    return !(firstColOccupied && lastColOccupied);

  }

}