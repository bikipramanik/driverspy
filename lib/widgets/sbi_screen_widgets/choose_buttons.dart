import 'package:flutter/material.dart';

class ChooseButtons extends StatelessWidget {
  const ChooseButtons({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.buttonText,
    required this.buttonIcon,
  });

  final double screenHeight;
  final double screenWidth;
  final String buttonText;
  final Icon buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * .07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(88, 196, 10, 229),
            const Color.fromARGB(139, 255, 86, 34)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonIcon,
          Text(buttonText),
        ],
      ),
    );
  }
}
