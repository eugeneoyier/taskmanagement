import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
 final TextEditingController controller;
 final String hintText;
 final bool? obscureText; // Make obscureText nullable
 final bool showIcon; // New parameter to control the visibility of the icon

 CustomTextField({
    required this.controller,
    required this.hintText,
    this.obscureText, // No default value, making it optional
    this.showIcon = true, // Default value is true, making it optional
 });

 @override
 _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
 bool _obscureText = false;

 @override
 void initState() {
    super.initState();
    _obscureText = widget.obscureText ?? false; // Use null-aware operator to handle null
 }

 @override
 Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.showIcon ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : null, // Conditionally show the icon based on the showIcon property
      ),
    );
 }
}