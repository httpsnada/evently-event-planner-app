import 'package:flutter/material.dart';

typedef Validator = String? Function(String? text);

class CustomFormField extends StatefulWidget {
  String labelText;

  IconData? prefixIcon;

  TextInputType keyboardType;

  bool isPassword;

  Validator? validator;

  TextEditingController? controller;

  int lines;

  CustomFormField({
    required this.labelText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.controller,
    this.lines = 1
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isTextVisible = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        maxLines: widget.lines,
        controller: widget.controller,
        obscureText: widget.isPassword ? isTextVisible : false,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : null,
          suffixIcon: widget.isPassword
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isTextVisible = !isTextVisible;
                    });
                  },
                  child: Icon(
                    isTextVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),

        validator: widget.validator,
        // if returned null -> no error
        // if returned string -> error message
      ),
    );
  }
}
