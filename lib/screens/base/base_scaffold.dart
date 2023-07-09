import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({
    required this.body,
    this.padding,
    this.appBar,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final EdgeInsetsGeometry? padding;
  final PreferredSizeWidget? appBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffold();
}

class _BaseScaffold extends ConsumerState<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.w, top: 18.w),
          child: widget.body,
        ),
      ),
    );
  }
}
