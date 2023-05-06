import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function? fieldSubmitted;
  final Function? validate;
  final String labelText;
  final Function? onChanged;
  final IconData? prefix;
  final Function? onTappedTextForm;
  final IconData? suffix;
  final bool isPassword;

  final Function? showPassword;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.inputType,
    this.fieldSubmitted,
    this.validate,
    required this.labelText,
    this.onChanged,
    this.prefix,
    this.onTappedTextForm,
    this.suffix,
    required this.isPassword,
    this.showPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.grey),
      cursorColor: Colors.black,
      keyboardType: inputType,
      controller: controller,
      validator: (String? value) {
        validate!(value);
        return null;
      },
      obscureText: isPassword,
      decoration: getInputDecoration(),
    );
  }

  InputBorder getUnderlineBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo, width: 0.2),
      );

  InputDecoration getInputDecoration() => InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
        focusedBorder: getUnderlineBorder(),
        enabledBorder: getUnderlineBorder(),
        border: getUnderlineBorder(),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: Colors.grey,
              )
            : null,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                  size: 20,
                  color: Colors.indigo,
                ),
                onPressed: () {
                  showPassword!();
                },
              )
            : null,
      );
}
