import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class BaseScaffold extends ConsumerStatefulWidget {
  const BaseScaffold({
    required this.body,
    this.padding,
    this.appBar,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final EdgeInsetsGeometry? padding;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffold();
}

class _BaseScaffold extends ConsumerState<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kAppBackGroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      appBar: widget.appBar,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.only(left: 8.w, right: 8.w, bottom: 0.w, top: 00.w),
          child: widget.body,
        ),
      ),
    );
  }
}
