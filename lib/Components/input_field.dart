// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final bool? obscure;
  final TextInputType? keyboard;
  String hint = '';
  final bool? readOnly;
  final TextAlign? textAlign;
  final Icon? icon;
  final IconButton? suffix;
  final String? prefixText;
  final VoidCallback? onTap;
  final bool? autoFocus;
  final double? fontSize;
  final FormFieldValidator<String>? fieldValidator;
  final FormFieldSetter<String>? fieldSetter;
  final Function(String)? onChanged;

  MyTextField({
    Key? key,
    this.textController,
    this.focusNode,
    this.obscure,
    this.keyboard,
    this.hint = '',
    this.readOnly,
    this.textAlign,
    this.icon,
    this.suffix,
    this.prefixText,
    this.onTap,
    this.autoFocus,
    this.fontSize,
    this.fieldValidator,
    this.fieldSetter,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: textController,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      textAlign: textAlign == null ? TextAlign.left : TextAlign.center,
      obscureText: obscure ?? false,
      keyboardType: keyboard,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: fontSize, color: Colors.grey.shade400),
        prefix: prefixText != null ? Text('$prefixText') : const Text(''),
        icon: icon,
        suffixIcon: suffix,
      ),
      autofocus: autoFocus ?? false,
      validator: fieldValidator,
      onFieldSubmitted: fieldSetter ?? (value) {},
      onChanged: onChanged,
    );
  }
}
