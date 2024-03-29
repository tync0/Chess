enum ChessCharacterEnum {
  pawn,
  rock,
  knight,
  bishop,
  queen,
  king,
}

class ChessCharacter {
  final ChessCharacterEnum chessChar;
  final bool isWhite;
  final String image;
  const ChessCharacter({
    required this.chessChar,
    required this.image,
    required this.isWhite,
  });
}
