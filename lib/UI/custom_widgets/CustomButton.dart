import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 final String text;
 final VoidCallback action; // Renamed from onPressed to action

 CustomButton({required this.text, required this.action}); // Updated parameter name

 @override
 Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action, // Use the new action parameter
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
 }
}