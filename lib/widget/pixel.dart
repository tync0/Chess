import 'package:chess/classes/chess_char.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Pixel extends StatelessWidget {
  final bool isWhite;
  final ChessCharacter? character;
  final void Function()? onTap;
  final bool selected;
  const Pixel({
    super.key,
    required this.isWhite,
    required this.character,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isWhite ? Colors.grey.shade500 : const Color(0XFf964d22),
          border: Border.all(
            color: selected ? Colors.green.shade400 : Colors.transparent,
            width: 4,
          ),
        ),
        child: character != null
            ? SvgPicture.asset(
                character!.image,
                colorFilter: ColorFilter.mode(
                  character!.isWhite ? Colors.white : Colors.black,
                  BlendMode.srcIn,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
