import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
 final String text;
 final TextStyle style;

 CustomText({required this.text, this.style = const TextStyle()});

 @override
 Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
 }
}