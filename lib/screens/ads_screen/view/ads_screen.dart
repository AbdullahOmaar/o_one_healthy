import 'package:app/common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';
import 'package:flutter/material.dart';

class AdsScreen extends StatefulWidget {
  static const routeName = "/AdsScreen";

  const AdsScreen({Key? key}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ads Screen')),
      bottomNavigationBar: CustomBottomBarWidget(),
    );
  }
}
