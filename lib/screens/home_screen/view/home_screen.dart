import 'package:app/common/widget_utils.dart';
import 'package:app/screens/login/view/login_screen.dart';
import 'package:app/screens/patients_files_search/view/patients_files_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.20,
                child: Image.asset(
                  'assets/images/logo/logo.jpeg',
                  fit: BoxFit.fill,
                )),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                  // ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(0,SelectedScreen.login);
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const PatientsFilesSearchScreen()));
                  // callData();
                },
                child: const Text('Patients Files',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                    // ref.read(bottomBarViewModelProvider.notifier).setCurrentScreen(0,SelectedScreen.login);
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const LoginScreen()),(route) => false,);
                },
                child: const Text('Login now',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                },
                child: const Text('subscription',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.5,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo,),
                onPressed: () {
                },
                child: const Text('ADS',style: TextStyle(fontSize: 16),),
              ),
            ),
            getVerticalSpacerWidget(context),
            getVerticalSpacerWidget(context),
            getVerticalSpacerWidget(context),
            const Text('واذا مرضت فهو يشفين',style: TextStyle(fontSize: 30),),
          ],
        ),
      )
    );
  }
}

