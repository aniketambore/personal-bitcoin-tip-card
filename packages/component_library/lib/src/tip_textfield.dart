import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class TipTextField extends StatelessWidget {
  const TipTextField({
    super.key,
    required this.hintText,
    this.focusNode,
    this.autoCorrect,
    this.enabled,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.onEditingComplete,
    this.controller,
  });

  final String hintText;
  final FocusNode? focusNode;
  final bool? autoCorrect;
  final bool? enabled;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Function()? onEditingComplete;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: FontSize.medium,
        color: black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: FontSize.medium,
          color: ghost,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ghost,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: persianBlue,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ghost,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: persianBlue,
          ),
        ),
        errorText: errorText,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      textInputAction: textInputAction,
      autocorrect: autoCorrect ?? true,
      onEditingComplete: onEditingComplete,
      controller: controller,
    );
  }
}
