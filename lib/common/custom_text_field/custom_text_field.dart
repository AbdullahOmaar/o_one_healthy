import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../custom_button.dart';

enum FieldBorder { underline, outline, custom }

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? inputType;
  final Function? fieldSubmitted;
  final Function? validate;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final IconData? prefix;
  final Function? onTappedTextForm;
  final IconData? suffix;
  final bool? isPassword;
  late CustomWidth customWidth;
  final Function? showPassword;
  late double fullWidth;
  FieldBorder fieldBorder;

  CustomTextField({
    Key? key,
    required this.controller,
    this.inputType,
    this.fieldSubmitted,
    this.validate,
    required this.labelText,
    this.onChanged,
    this.prefix,
    this.onTappedTextForm,
    this.suffix,
    this.isPassword,
    this.showPassword,
    this.fieldBorder = FieldBorder.outline,
    this.customWidth = CustomWidth.matchParent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 55,
      child: TextFormField(
        style: TextStyle(color: ThemeColors.kBlack),
        cursorColor: ThemeColors.kPrimary,
        keyboardType: inputType,
        controller: controller,
        onChanged: onChanged,
        validator: (String? value) {
          return validate!(value);
        },
        obscureText: isPassword ?? false,
        decoration: getInputDecoration(),
      ),
    );
  }

  InputBorder getUnderlineBorder() => UnderlineInputBorder(
        borderSide: BorderSide(color: ThemeColors.kPrimary, width: 0.2),
      );

  getTextFieldBorder() {
    switch (fieldBorder) {
      case FieldBorder.underline:
        return getUnderlineBorder();
      case FieldBorder.outline:
        return OutlineInputBorder(
          borderSide: BorderSide(
              color: ThemeColors.kPrimary,
              width: 1.5,
              style: BorderStyle.solid),
        );
      case FieldBorder.custom:
        return const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          borderSide: BorderSide(
              color: Colors.indigo, width: 0.9, style: BorderStyle.solid),
        );
    }
  }

  InputDecoration getInputDecoration() => InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        labelText: labelText,
        labelStyle: TextStyle(
          height: .5,
          color: ThemeColors.primary,
          fontSize: 14.sp,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors.kPrimaryLight,
            width: 1.5,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: getTextFieldBorder(),
        border: getTextFieldBorder(),
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
