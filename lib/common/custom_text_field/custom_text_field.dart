import 'package:flutter/material.dart';

import '../custom_button.dart';
import '../widget_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final Function? fieldSubmitted;
  final Function? validate;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final IconData? prefix;
  final Function? onTappedTextForm;
  final IconData? suffix;
  final bool isPassword;
  late CustomWidth customWidth;
  final Function? showPassword;
  late double fullWidth;


  CustomTextField({
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
    this.customWidth =CustomWidth.matchParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fullWidth =MediaQuery.of(context).size.width;

    return SizedBox(
      width: getWidgetWidth(fullWidth,customWidth),
      child: TextFormField(
        style: const TextStyle(color: Colors.grey),
        cursorColor: Colors.black,
        keyboardType: inputType,
        controller: controller,
        onChanged: onChanged,
        validator: (String? value) {
          return validate!(value);
        },
        obscureText: isPassword,
        decoration: getInputDecoration(),
      ),
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
