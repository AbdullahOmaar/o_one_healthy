import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coomon/bottom_bar_widget/bottom_bar_view.dart';
import 'coomon/bottombar_view_model/bottomBar_view_model.dart';

void main() {
  runApp( const ProviderScope(
      child: MyApp()
  ));
}

class MyApp extends ConsumerStatefulWidget{
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp>{

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
          bottomNavigationBar:const CustomBottomBarWidget(),
          body: ref.watch(bottomBarViewModelProvider.notifier).screens[ref.watch(bottomBarViewModelProvider).currentIndex]),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: const LoginScreen()
//     );
//   }
// }
