import 'package:flutter/material.dart';

class KeyboardButtonWidget extends StatelessWidget {
  const KeyboardButtonWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 3,
        shadowColor: Theme.of(context).shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(text,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  )),
        ),
      ),
    );
  }
}
