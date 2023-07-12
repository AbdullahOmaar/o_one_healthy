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
  final Widget? bottomNavigationBar ;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScaffold();
}

class _BaseScaffold extends ConsumerState<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:widget.bottomNavigationBar ,
      appBar: widget.appBar,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.w, top: 20.w),
          child: widget.body,
        ),
      ),
    );
  }
}
