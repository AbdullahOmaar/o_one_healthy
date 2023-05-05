import 'package:app/screens/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../coomon/bottombar_view_model/bottomBar_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body:  Center(child: TextButton(onPressed: (){
        ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(0,SelectedScreen.login);

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const LoginScreen()),(route) => false,);
      },child:const Text('Login'),),)
    );
  }
}
