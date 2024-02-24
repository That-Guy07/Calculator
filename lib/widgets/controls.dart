import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({
    super.key,
    required this.backspace,
  });

  final void Function() backspace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {},
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.backspace),
                  onPressed: backspace,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
