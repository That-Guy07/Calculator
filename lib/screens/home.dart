import 'package:flutter/material.dart';
import 'package:calculator/widgets/view_board.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/keyboard.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
String _viewBoardData = '0';
Map<String, List<String>> _history = {};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/history.text');
  }

  Future<File> _writeHistory(String data) async {
    final file = await _localFile;
    return file.writeAsString(data);
  }

  Future<String> readHistory() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return '[]';
    }
  }

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
    } else if (_viewBoardData == '0') {
      _addViewBoardData('0$data');
    } else {
      _addViewBoardData(data);
    }
  }

  void _addPercentage() {
    if (_viewBoardData.endsWith('x') ||
        _viewBoardData.endsWith('÷') ||
        _viewBoardData.endsWith('+') ||
        _viewBoardData.endsWith('-') ||
        _viewBoardData.endsWith('%') ||
        _viewBoardData.endsWith('(') ||
        _viewBoardData == '0') {
    } else {
      _addViewBoardData('%');
    }
  }

  dynamic _simplifier() {
    final uniqueId = uuid.v1();
    final _viewBoardDataCopy = _viewBoardData;

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
      _history[uniqueId] = [_viewBoardDataCopy, result.toString()];
      _writeHistory(_history.toString());
    } catch (e) {
      // print(e);
    }
    print(_history);
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
      if (_viewBoardData == '2201') {
        _updateViewBoardData('I still love her.');
      } else if (_viewBoardData == '2606') {
        _updateViewBoardData('Pranami Chutiya hai.');
      } else {
        _updateViewBoardData(_simplifier().toString());
      }
    } else if (data == '.') {
      _addDecimal();
    } else {
      _addNumber(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final _screenWidth = MediaQuery.of(context).size.width;
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
            ViewBoardWidget(
              viewBoardData: _viewBoardData,
              screenHeight: _screenHeight,
              screenWidth: _screenWidth,
            ),
            const Spacer(),
            ControlsWidget(
              backspace: _removeLastViewBoardData,
              readHistory: readHistory,
            ),
            KeyboardWidget(
              onPressed: _onPressed,
              screenHeight: _screenHeight,
              screenWidth: _screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}
