import 'package:flutter/material.dart';

class ViewBoardWidget extends StatefulWidget {
  const ViewBoardWidget({
    super.key,
    required this.viewBoardData,
    required this.screenHeight,
    required this.screenWidth,
  });

  final String viewBoardData;
  final double screenHeight;
  final double screenWidth;

  @override
  State<ViewBoardWidget> createState() {
    return _ViewBoardWidgetState();
  }
}

class _ViewBoardWidgetState extends State<ViewBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        color: Theme.of(context).colorScheme.background,
        child: Text(
          maxLines: 2,
          overflow: TextOverflow.fade,
          widget.viewBoardData,
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 40,
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
              ),
        ),
      ),
    );
  }
}
