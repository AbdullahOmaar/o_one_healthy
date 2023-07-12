import 'package:app/util/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../bottombar_view_model/bottomBar_view_model.dart';

class CustomBottomBarWidget extends ConsumerStatefulWidget {
  const CustomBottomBarWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomBottomBarWidgetState();
}

class _CustomBottomBarWidgetState extends ConsumerState<CustomBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(

      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: ThemeColors.kPrimary,), label: "home"),
         BottomNavigationBarItem(
            icon: Icon(Icons.ads_click, color:ThemeColors.kPrimary,), label: "ads"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined, color: ThemeColors.kPrimary,), label: "subscribers"),
      ],
      currentIndex: ref.watch(bottomBarViewModelProvider).currentIndex,
      selectedItemColor: ThemeColors.kPrimary,
      unselectedItemColor: Colors.grey,
      onTap: (i){
        ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(i,SelectedScreen.none, context: context);
      },
      // selectedLabelStyle:const TextStyle(color: Colors.red, fontSize: 20),
    );
  }
}
