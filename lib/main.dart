import 'package:app/routes/app_routes.dart';
import 'package:app/routes/route_generator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
    child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'AR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'AR'),
        child: const MyApp()),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
          // primarySwatch: Themes.kPrimarySwatch,
          ),
      initialRoute: getInitialPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

  String getInitialPage() => AppRoutes.home;
}

// Scaffold(
// bottomNavigationBar:const CustomBottomBarWidget(),
// body: ref.watch(bottomBarViewModelProvider.notifier).screens[ref.watch(bottomBarViewModelProvider).currentIndex]),
// );
