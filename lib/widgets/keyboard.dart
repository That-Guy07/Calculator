import 'package:flutter/material.dart';
import 'package:calculator/widgets/keyboard_button.dart';

List<String> _buttonTexts = [
  'C',
  '()',
  '%',
  '÷',
  '7',
  '8',
  '9',
  'x',
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
  const KeyboardWidget({
    super.key,
    required this.onPressed,
    required this.screenHeight,
    required this.screenWidth,
  });

  final void Function(String) onPressed;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (screenWidth / 4) * 5,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        alignment: Alignment.center,
        color: Theme.of(context).colorScheme.background,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          children: [
            ..._buttonTexts.map(
              (text) => KeyboardButtonWidget(
                text: text,
                onPressed: (data) {
                  onPressed(data);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
