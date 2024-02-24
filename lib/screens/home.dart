import 'package:flutter/material.dart';
import 'package:calculator/widgets/view_board.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/keyboard.dart';

String _viewBoardData = '0.0';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  void _updateViewBoardData(String data) {
    setState(() {
      _viewBoardData = data;
    });
  }

  void _clearViewBoardData() {
    setState(() {
      _viewBoardData = '0';
    });
  }

  void _removeLastViewBoardData() {
    if (_viewBoardData.length > 1) {
      setState(() {
        _viewBoardData = _viewBoardData.substring(0, _viewBoardData.length - 1);
      });
    } else {
      _clearViewBoardData();
    }
  }

  void _addViewBoardData(String data) {
    setState(() {
      if (_viewBoardData == '0') {
        _viewBoardData = data;
      } else {
        _viewBoardData += data;
      }
    });
  }

  void _onPressed(String data) {
    if (data == 'C') {
      _clearViewBoardData();
    } else if (data == '()') {
      _addViewBoardData('()');
    } else if (data == '%') {
      _addViewBoardData('%');
    } else if (data == '÷') {
      _addViewBoardData('÷');
    } else if (data == 'x') {
      _addViewBoardData('x');
    } else if (data == '-') {
      _addViewBoardData('-');
    } else if (data == '+') {
      _addViewBoardData('+');
    } else if (data == '+/-') {
      _addViewBoardData('+/-');
    } else if (data == '=') {
      _addViewBoardData('=');
    } else {
      _addViewBoardData(data);
    }
  }

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
            ControlsWidget(
              backspace: _removeLastViewBoardData,
            ),
            KeyboardWidget(
              onPressed: _onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
