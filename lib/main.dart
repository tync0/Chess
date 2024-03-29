import 'package:chess/classes/position_class.dart';
import 'package:chess/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChessPositions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chess',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const MainView(),
      ),
    );
  }
}
