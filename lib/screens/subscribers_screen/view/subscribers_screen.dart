import 'package:flutter/material.dart';

import '../../../common/bottom_bar/bottom_bar_widget/bottom_bar_view.dart';

class SubscribersScreen extends StatefulWidget {
  const SubscribersScreen({Key? key}) : super(key: key);
  static const routeName = "/SubscribersScreen";

  @override
  State<SubscribersScreen> createState() => _SubscribersScreenState();
}

class _SubscribersScreenState extends State<SubscribersScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: Text('Subscribers Screen'),
      bottomNavigationBar: CustomBottomBarWidget(),
    );
  }
}
