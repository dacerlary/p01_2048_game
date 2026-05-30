import 'package:flutter/material.dart';

import '../const/colors.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
  });

  final String? text;
  final IconData? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Container(
        decoration: BoxDecoration(
          color: colorApp.button,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: colorApp.textWhite, width: 2),
          boxShadow: [
            BoxShadow(
              color: colorApp.button.withValues(alpha: 0.34),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          color: colorApp.textWhite,
          onPressed: onPressed,
          icon: Icon(icon, size: 24.0),
        ),
      );
    }
    return ElevatedButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(16.0),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(colorApp.button),
        foregroundColor: WidgetStateProperty.all<Color>(colorApp.textWhite),
        elevation: WidgetStateProperty.all<double>(6),
      ),
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }
}
