import 'package:calculator/screens/history_bottom_sheet_screen.dart';
import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({
    super.key,
    required this.backspace,
    required this.readHistory,
  });

  final void Function() backspace;
  final Future<String> Function() readHistory;

  @override
  Widget build(BuildContext context) {
    void _openHistoryBottomSheet() {
      // readHistory();
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return const HistoryBottomSheetScreen();
          });
    }

    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.history),
                  onPressed: _openHistoryBottomSheet,
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: const Icon(Icons.compare_arrows),
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
