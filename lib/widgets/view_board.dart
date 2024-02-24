import 'package:flutter/material.dart';

class ViewBoardWidget extends StatefulWidget {
  const ViewBoardWidget({super.key, required this.viewBoardData});

  final String viewBoardData;

  @override
  State<ViewBoardWidget> createState() {
    return _ViewBoardWidgetState();
  }
}

class _ViewBoardWidgetState extends State<ViewBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Theme.of(context).colorScheme.background,
        // child: TextField(
        //   autofocus: true,
        //   textAlign: TextAlign.right,
        //   style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //         fontSize: 30,
        //       ),
        //   keyboardType: TextInputType.none,
        //   decoration: const InputDecoration(
        //     border: InputBorder.none,
        //     contentPadding: EdgeInsets.all(30),
        //   ),
        // ),
        child: Text(
          widget.viewBoardData,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 40,
              ),
        ),
      ),
    );
  }
}
