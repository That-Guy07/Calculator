import 'package:flutter/material.dart';

class HistoryBottomSheetScreen extends StatefulWidget {
  const HistoryBottomSheetScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoryBottomSheetScreenState();
  }
}

class _HistoryBottomSheetScreenState extends State<HistoryBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
          child: Icon(
            size: 40,
            Icons.remove_rounded,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return const ListTile(
                title: Text('Expresion'),
                subtitle: Text('result'),
                trailing: Icon(Icons.close_rounded),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
