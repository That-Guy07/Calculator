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

  void _addNumber(String data) {
    if (_viewBoardData.endsWith('%')) {
      _addViewBoardData('x$data');
    } else {
      _addViewBoardData(data);
    }
  }

  void _addDecimal() {
    int operatorCount = 0;
    int decimalCount = 0;
    if (_viewBoardData == '0') {
      _addViewBoardData('0.');
    } else {
      for (int i = 0; i < _viewBoardData.length; i++) {
        if (_viewBoardData[i] == '+' ||
            _viewBoardData[i] == '-' ||
            _viewBoardData[i] == 'x' ||
            _viewBoardData[i] == '÷') {
          operatorCount++;
        }
      }
      for (int i = 0; i < _viewBoardData.length; i++) {
        if (_viewBoardData[i] == '.') {
          decimalCount++;
        }
      }
      if (decimalCount == 0) {
        _addViewBoardData('.');
      } else if (decimalCount - operatorCount == 0) {
        if (_viewBoardData.endsWith('+') ||
            _viewBoardData.endsWith('-') ||
            _viewBoardData.endsWith('x') ||
            _viewBoardData.endsWith('÷') ||
            _viewBoardData.endsWith('%') ||
            _viewBoardData.endsWith('(') ||
            _viewBoardData.endsWith(')')) {
          _addViewBoardData('0.');
        } else {
          _addViewBoardData('.');
        }
      }
    }
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
      } else if (_bracketCount == 0) {
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

  void _addOperator(String data) {
    if (_viewBoardData.endsWith('x') ||
        _viewBoardData.endsWith('÷') ||
        _viewBoardData.endsWith('+') ||
        _viewBoardData.endsWith('-')) {
      _removeLastViewBoardData();
      _addViewBoardData(data);
    } else {
      _addViewBoardData(data);
    }
  }

  void _addPercentage() {
    if (_viewBoardData.endsWith('x') ||
        _viewBoardData.endsWith('÷') ||
        _viewBoardData.endsWith('+') ||
        _viewBoardData.endsWith('-') ||
        _viewBoardData.endsWith('%')) {
    } else {
      _addViewBoardData('%');
    }
  }

  dynamic _simplifier() {
    dynamic result = 0;
    List<dynamic> values = [];

    if (_viewBoardData.contains('%')) {
      _viewBoardData = _viewBoardData.replaceAll('%', '/100');
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
    try {
      Expression exp = P.parse(result);
      result = exp.evaluate(EvaluationType.REAL, ContextModel());
    } catch (e) {
      print(e);
    }

    // print(values);
    // print(result);
    // print(result.runtimeType);
    return result;
  }

  void _onPressed(String data) {
    if (data == 'C') {
      _clearViewBoardData();
    } else if (data == '()') {
      _addBracket();
    } else if (data == '%') {
      _addPercentage();
    } else if (data == '÷') {
      _addOperator('÷');
    } else if (data == 'x') {
      _addOperator('x');
    } else if (data == '-') {
      _addViewBoardData(data);
    } else if (data == '+') {
      _addOperator('+');
    } else if (data == '+/-') {
      _plusMinus();
    } else if (data == '=') {
      _updateViewBoardData(_simplifier().toString());
    } else if (data == '.') {
      _addDecimal();
    } else {
      _addNumber(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Text(
          'Calculator',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              ),
        ),
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
