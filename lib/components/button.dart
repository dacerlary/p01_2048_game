import 'package:flutter/material.dart';

import '../const/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key, this.text, this.icon, required this.onPressed});

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Container(
        decoration: BoxDecoration(
            color: colorApp.score, borderRadius: BorderRadius.circular(8.0)),
        child: IconButton(
            color: colorApp.textWhite,
            onPressed: onPressed,
            icon: Icon(
              icon,
              size: 24.0,
            )),
      );
    }
    return ElevatedButton(
        style: ButtonStyle(
            padding:
                WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(16.0)),
            backgroundColor: WidgetStateProperty.all<Color>(colorApp.button)),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ));
  }
}
