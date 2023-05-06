import 'package:app/screens/ads_screen/view/ads_screen.dart';
import 'package:app/screens/home_screen/view/home_screen.dart';
import 'package:app/screens/subscribers_screen/view/subscribers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final bottomBarViewModelProvider =
    StateNotifierProvider<BottomBarViewModel, SelectedFragmentState>(
        (ref) => BottomBarViewModel());

class SelectedFragmentState {
   int currentIndex;
   SelectedScreen selectedScreen;
  SelectedFragmentState({required this.currentIndex,required this.selectedScreen});

  SelectedFragmentState copyWith({required int currentIndex,required SelectedScreen selectedScreen}) {
    return SelectedFragmentState(
      currentIndex: currentIndex ,
      selectedScreen: selectedScreen
    );
  }
}
enum SelectedScreen {
 login,
  none
}
class BottomBarViewModel extends StateNotifier<SelectedFragmentState> {

  List<Widget> screens = [
    const HomeScreen(),
    const AdsScreen(),
    const SubscribersScreen(),
  ];

  BottomBarViewModel() : super(SelectedFragmentState(currentIndex: 0,selectedScreen: SelectedScreen.login));

  setCurrentScreen(int currentIndex, SelectedScreen selectedScreen) async {
    state = state.copyWith(
      currentIndex: currentIndex,
      selectedScreen: selectedScreen
    );
  }

  Widget getCurrentScreen(SelectedScreen selectedScreen,){
    if(selectedScreen ==SelectedScreen.login) {
      return const Center(child: Text('login'),);
    } else {
      return     screens[state.currentIndex];
    }


  }
}
