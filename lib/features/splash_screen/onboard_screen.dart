import 'package:flutter/material.dart';
import 'package:yatra/core/constants/app_color.dart';

class OnboardScreen extends StatelessWidget {
  final String image;
  final String title, highLightWord, subtitle;

  const OnboardScreen({
    super.key,
    required this.image,
    required this.title,
    required this.highLightWord,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30),
        // Logo
        Image.asset(image),
        SizedBox(height: 20),
        // Title with highlighted word
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
            children: [
              TextSpan(text: title),
              TextSpan(
                text: highLightWord,
                style: TextStyle(
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(color: Colors.grey, height: 1.4, fontSize: 14),
              children: [TextSpan(text: subtitle)],
            ),
          ),
        ),
      ],
    );
  }
}
