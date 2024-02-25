import 'package:flutter/material.dart';
import 'package:calculator/widgets/view_board.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/keyboard.dart';
import 'package:math_expressions/math_expressions.dart';

String _viewBoardData = '0';

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

  void _plusMinus() {
    setState(() {
      if (_viewBoardData.startsWith('-')) {
        _viewBoardData = _viewBoardData.substring(1);
      } else {
        _viewBoardData = '-$_viewBoardData';
      }
    });
  }

  void _addBracket() {
    int _bracketCount = 0;
    for (int i = 0; i < _viewBoardData.length; i++) {
      if (_viewBoardData[i] == '(') {
        _bracketCount++;
      } else if (_viewBoardData[i] == ')') {
        _bracketCount--;
      }
    }
    setState(() {
      if (_viewBoardData.endsWith('(') || _viewBoardData == '0') {
        _addViewBoardData('(');
      } else if (_viewBoardData.endsWith(')') && _bracketCount == 0) {
        _addViewBoardData('x(');
      } else if (_viewBoardData.endsWith('%')) {
        _addViewBoardData('(');
      } else if (_viewBoardData.endsWith('÷')) {
        _addViewBoardData('(');
      } else if (_viewBoardData.endsWith('x')) {
        _addViewBoardData('(');
      } else if (_viewBoardData.endsWith('+')) {
        _addViewBoardData('(');
      } else if (_viewBoardData.endsWith('-')) {
        _addViewBoardData('(');
      } else {
        _addViewBoardData(')');
      }
    });
  }

  dynamic _simplifier() {
    dynamic result = 0;
    List<dynamic> values = [];

    if (_viewBoardData.contains('%')) {
      _viewBoardData = _viewBoardData.replaceAll('%', '/100*');
    }
    if (_viewBoardData.contains('x')) {
      _viewBoardData = _viewBoardData.replaceAll('x', '*');
    }
    if (_viewBoardData.contains('÷')) {
      _viewBoardData = _viewBoardData.replaceAll('÷', '/');
    }
    values = _viewBoardData.split('');
    result = values.join();
    Parser P = Parser();
    Expression exp = P.parse(result);
    result = exp.evaluate(EvaluationType.REAL, ContextModel());

    print(values);
    print(result);
    print(result.runtimeType);
    return result;
  }

  void _onPressed(String data) {
    if (data == 'C') {
      _clearViewBoardData();
    } else if (data == '()') {
      _addBracket();
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
      _plusMinus();
    } else if (data == '=') {
      _updateViewBoardData(_simplifier().toString());
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
