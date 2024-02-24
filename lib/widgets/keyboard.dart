import 'package:flutter/material.dart';
import 'package:calculator/widgets/keyboard_button.dart';

final List<String> buttonValues = [
  'C',
  '()',
  '%',
  '÷',
  '7',
  '8',
  '9',
  '×',
  '4',
  '5',
  '6',
  '-',
  '1',
  '2',
  '3',
  '+',
  '+/-',
  '0',
  '.',
  '='
];

class KeyboardWidget extends StatelessWidget {
  const KeyboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: [
            ...buttonValues.map(
              (text) => KeyboardButtonWidget(text: text),
            ),
          ],
        ),
      ),
    );
  }
}
