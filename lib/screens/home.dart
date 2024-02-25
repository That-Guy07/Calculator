import 'package:flutter/material.dart';
import 'package:calculator/widgets/view_board.dart';
import 'package:calculator/widgets/controls.dart';
import 'package:calculator/widgets/keyboard.dart';

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

  // String _simplifier() {
  //   List<String> values = [];
  //   String result = '0';
  //   if (_viewBoardData.contains('x')) {
  //     values = _viewBoardData.split('x');
  //     result = (double.parse(values[0]) * double.parse(values[1])).toString();
  //   }
  //   if (_viewBoardData.contains('÷')) {
  //     values = _viewBoardData.split('÷');
  //     result = (double.parse(values[0]) / double.parse(values[1])).toString();
  //   }
  //   if (_viewBoardData.contains('%')) {
  //     values = _viewBoardData.split('%');
  //     result = (double.parse(values[0]) % double.parse(values[1])).toString();
  //   }
  //   if (_viewBoardData.contains('+')) {
  //     values = _viewBoardData.split('+');
  //     result = (double.parse(values[0]) + double.parse(values[1])).toString();
  //   }
  //   if (_viewBoardData.contains('-')) {
  //     values = _viewBoardData.split('-');
  //     result = (double.parse(values[0]) - double.parse(values[1])).toString();
  //   }
  //   print(values);
  //   return result;
  // }

  dynamic _simplifier() {
    dynamic result = '10 + 2';
    List<dynamic> values = [];
    // double i = (1 / 100 * (5 * 8));

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
    for (int i = 0; i < values.length; i++) {
      try {
        values[i] = int.parse(values[i]);
      } catch (e) {
        print(values[i] + ' is not a number');
      }
    }

    // result = values.join();
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
