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

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue,), label: "home"),
         BottomNavigationBarItem(
            icon: Icon(Icons.ads_click, color: Colors.blue,), label: "ads"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined, color: Colors.blue,), label: "subscribers"),
      ],
      currentIndex: ref.watch(bottomBarViewModelProvider).currentIndex,
      fixedColor: Colors.deepPurple,
      onTap: (i){
        ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(i,SelectedScreen.none);
      },
      selectedLabelStyle:const TextStyle(color: Colors.red, fontSize: 20),
    );
  }
}
