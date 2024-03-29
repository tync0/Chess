import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/position_class.dart';
import '../widget/pixel.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies called');
    Future.microtask(() {
      context.read<ChessPositions>().initElements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Consumer<ChessPositions>(
              builder: (context, value, child) => GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 64,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) {
                  int x = index ~/ 8; // row
                  int y = index % 8; // column
                  bool isWhite = (x + y) % 2 == 0;
                  //bool selected = selectedIndex == index;
                  return Pixel(
                    isWhite: isWhite,
                    character: value.characterPositions[x][y],
                    onTap: () {
                      if (value.selectedIndex == index) {
                        value.unSelected();
                      } else {
                        if (value.selectedIndex == -1) {
                          value.selectItem(x, y);
                        } else {
                          value.changeCharacter(x, y, index);
                        }
                      }
                    },
                    selected: value.selectedItems.contains(index),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
