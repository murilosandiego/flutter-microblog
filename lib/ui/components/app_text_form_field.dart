import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextFormField extends StatelessWidget {
  final String label;
  final Function onTap;
  final ValueChanged<String> onChanged;
  final Function onEditingComplete;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String) onSaved;
  final bool autocorrect;
  final FormFieldValidator<String> validator;
  final String errorText;
  final String initialValue;
  final TextEditingController controller;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;

  final String hintText;
  final TextInputAction textInputAction;
  final Widget suffix;
  final Widget suffixIcon;
  final bool autofocus;

  const AppTextFormField({
    this.label,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.textInputType,
    this.onSaved,
    this.autocorrect = false,
    this.obscureText = false,
    this.validator,
    this.errorText,
    this.initialValue,
    this.controller,
    this.maxLines = 1,
    this.inputFormatters,
    this.hintText,
    this.textInputAction,
    this.suffix,
    this.suffixIcon,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      controller: controller,
      initialValue: initialValue,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText,
      keyboardType: textInputType,
      onSaved: onSaved,
      autocorrect: autocorrect,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffix: suffix,
        hintText: label,
        errorText: errorText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
