import 'package:chess/classes/chess_char.dart';
import 'package:flutter/material.dart';
import '../const.dart';

class ChessPositions extends ChangeNotifier {
  ChessCharacter? selectedItem;
  List<List<ChessCharacter?>> characterPositions = List.generate(
    8,
    (index) => List.generate(8, (index) => null),
  );
  int selectedRow = -1;
  int selectedColumn = -1;
  int selectedIndex = -1;
  List<int> selectedItems = [];
  void initElements() {
    //pawn
    for (int i = 0; i < 8; i++) {
      characterPositions[1][i] = const ChessCharacter(
        chessChar: ChessCharacterEnum.pawn,
        image: AssetConst.pawn,
        isWhite: true,
      );
      characterPositions[6][i] = const ChessCharacter(
        chessChar: ChessCharacterEnum.pawn,
        image: AssetConst.pawn,
        isWhite: false,
      );
    }
    //rock
    characterPositions[0][0] = const ChessCharacter(
      chessChar: ChessCharacterEnum.rock,
      image: AssetConst.rock,
      isWhite: true,
    );
    characterPositions[0][7] = const ChessCharacter(
      chessChar: ChessCharacterEnum.rock,
      image: AssetConst.rock,
      isWhite: true,
    );
    characterPositions[7][0] = const ChessCharacter(
      chessChar: ChessCharacterEnum.rock,
      image: AssetConst.rock,
      isWhite: false,
    );
    characterPositions[7][7] = const ChessCharacter(
      chessChar: ChessCharacterEnum.rock,
      image: AssetConst.rock,
      isWhite: false,
    );
    //knight
    characterPositions[0][1] = const ChessCharacter(
      chessChar: ChessCharacterEnum.knight,
      image: AssetConst.knight,
      isWhite: true,
    );
    characterPositions[0][6] = const ChessCharacter(
      chessChar: ChessCharacterEnum.knight,
      image: AssetConst.knight,
      isWhite: true,
    );
    characterPositions[7][1] = const ChessCharacter(
      chessChar: ChessCharacterEnum.knight,
      image: AssetConst.knight,
      isWhite: false,
    );
    characterPositions[7][6] = const ChessCharacter(
      chessChar: ChessCharacterEnum.knight,
      image: AssetConst.knight,
      isWhite: false,
    );
    //bishop
    characterPositions[0][2] = const ChessCharacter(
      chessChar: ChessCharacterEnum.bishop,
      image: AssetConst.bishop,
      isWhite: true,
    );
    characterPositions[0][5] = const ChessCharacter(
      chessChar: ChessCharacterEnum.bishop,
      image: AssetConst.bishop,
      isWhite: true,
    );
    characterPositions[7][2] = const ChessCharacter(
      chessChar: ChessCharacterEnum.bishop,
      image: AssetConst.bishop,
      isWhite: false,
    );
    characterPositions[7][5] = const ChessCharacter(
      chessChar: ChessCharacterEnum.bishop,
      image: AssetConst.bishop,
      isWhite: false,
    );

    //queen
    characterPositions[0][3] = const ChessCharacter(
      chessChar: ChessCharacterEnum.queen,
      image: AssetConst.queen,
      isWhite: true,
    );
    characterPositions[7][4] = const ChessCharacter(
      chessChar: ChessCharacterEnum.queen,
      image: AssetConst.queen,
      isWhite: false,
    );
    //king
    characterPositions[0][4] = const ChessCharacter(
      chessChar: ChessCharacterEnum.king,
      image: AssetConst.king,
      isWhite: true,
    );
    characterPositions[7][3] = const ChessCharacter(
      chessChar: ChessCharacterEnum.king,
      image: AssetConst.king,
      isWhite: false,
    );
    notifyListeners();
  }

  void selectItem(int row, int column) {
    if (characterPositions[row][column] != null) {
      selectedItem = characterPositions[row][column];
      selectedItems.add(row * 8 + column);
      switch (selectedItem!.chessChar) {
        case ChessCharacterEnum.pawn:
          pawnPath(row, column);
          break;
        case ChessCharacterEnum.knight:
          knightPath(row, column);
          break;
        case ChessCharacterEnum.bishop:
          bishopPath(row, column);
          break;
        case ChessCharacterEnum.rock:
          rockPath(row, column);
        case ChessCharacterEnum.queen:
          rockPath(row, column);
          bishopPath(row, column);
          break;
        default:
      }
      selectedRow = row;
      selectedColumn = column;
      selectedIndex = row * 8 + column;
      notifyListeners();
    }
  }

  void unSelected() {
    selectedItems = [];
    selectedIndex = -1;
    notifyListeners();
  }

  void changeCharacter(int x, int y, int index) {
    if (selectedItems.contains(index)) {
      characterPositions[x][y] =
          characterPositions[selectedRow][selectedColumn];
      characterPositions[selectedRow][selectedColumn] = null;
      selectedColumn = -1;
      selectedRow = -1;
      selectedItems = [];
      selectedIndex = -1;
    }

    notifyListeners();
  }

  void pawnPath(int row, int column) {
    if (row == 6) {
      selectedItems.add((row - 1) * 8 + column);
      selectedItems.add((row - 2) * 8 + column);
    } else {
      selectedItems.add((row - 1) * 8 + column);
    }
  }

  void knightPath(int row, int column) {
    selectedItems.addAll(
      [
        (row - 2) * 8 + column - 1,
        (row - 2) * 8 + column + 1,
        (row - 1) * 8 + column + 2,
        (row - 1) * 8 + column - 2,
      ],
    );
  }

  void bishopPath(int row, int column) {
    int x = row - 1;
    int y = column + 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x -= 1;
      y += 1;
    }
    x = row - 1;
    y = column - 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x -= 1;
      y -= 1;
    }
    x = row + 1;
    y = column + 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x += 1;
      y += 1;
    }
    x = row + 1;
    y = column - 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x += 1;
      y -= 1;
    }
  }

  void rockPath(int row, int column) {
    int x = row - 1;
    int y = column;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x -= 1;
    }
    x = row + 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      x += 1;
    }
    x = row;
    y = column + 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      y += 1;
    }
    y = column - 1;
    while (checker(x, y)) {
      selectedItems.add(x * 8 + y);
      y -= 1;
    }
  }

  bool checker(int row, int column) {
    if ((row <= 7 && row >= 0) && (column <= 7 && column >= 0)) {
      return true;
    }

    return false;
  }
}
