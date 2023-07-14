import 'package:flutter/material.dart';

class UiText extends Text {
  const UiText(
      {super.key,
      super.style,
      super.overflow,
      super.softWrap,
      String? text,
      String fallback = ''})
      : super(text ?? fallback);
}
