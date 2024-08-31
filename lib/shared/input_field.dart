import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? label;
  final String? hint;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final bool obscure;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final void Function(String?)? onEditingComplete;
  final FocusNode? node;
  final int? maxLines;
  const InputField({
    super.key,
    required this.textEditingController,
    this.label,
    this.suffixWidget,
    this.prefixWidget,
    this.hint,
    this.fillColor,
    this.obscure = false,
    this.validator,
    this.textInputType,
    this.node,
    this.onEditingComplete,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscure,
      validator: validator,
      keyboardType: textInputType,
      onSaved: onEditingComplete,
      maxLines: maxLines,
      focusNode: node,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
