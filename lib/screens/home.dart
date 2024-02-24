import 'package:flutter/material.dart';
import 'package:calculator/widgets/view_board.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/keyboard.dart';

String _viewBoardData = '0.0';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text('Calculator'),
      ),
      body: Center(
        child: Column(
          children: [
            ViewBoardWidget(viewBoardData: _viewBoardData),
            const Spacer(),
            const ControlsWidget(),
            const KeyboardWidget(),
          ],
        ),
      ),
    );
  }
}
