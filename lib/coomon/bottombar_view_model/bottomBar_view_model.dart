import 'package:app/screens/home_screen/view/home_fragment_screen.dart';
import 'package:app/screens/login/model/login_model.dart';
import 'package:app/screens/login/repository/login_repository.dart';
import 'package:app/screens/subscribers_screen/view/subscribers_fragment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/ads_screen/view/ads_fragment_screen.dart';

final bottomBarViewModelProvider =
    StateNotifierProvider<BottomBarViewModel, SelectedFragmentState>(
        (ref) => BottomBarViewModel());

class SelectedFragmentState {
   int currentIndex;
   List<Widget> screens = [
     const HomeScreen(),
     const AdsScreen(),
     const SubscribersScreen(),
     const Text('a')
   ];
  SelectedFragmentState({required this.currentIndex});

  SelectedFragmentState copyWith({required int currentIndex}) {
    return SelectedFragmentState(
      currentIndex: currentIndex ,
    );
  }
}

class BottomBarViewModel extends StateNotifier<SelectedFragmentState> {



  BottomBarViewModel() : super(SelectedFragmentState(currentIndex: 0));

  setCurrentScreen(int currentIndex) async {
    state = state.copyWith(
      currentIndex: currentIndex,
    );
  }
}
