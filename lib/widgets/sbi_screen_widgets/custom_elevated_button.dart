import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.buttonSize,
    required this.fontSize,
    required this.mainAxisAlignment,
    required this.onPressed,
  });

  final String buttonText;
  final Icon buttonIcon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Size buttonSize;
  final double fontSize;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: buttonSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        padding: EdgeInsets.symmetric(horizontal: 24),
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          buttonIcon,
          Text(buttonText),
        ],
      ),
    );
  }
}
