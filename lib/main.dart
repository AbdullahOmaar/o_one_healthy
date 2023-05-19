import 'package:app/routes/app_routes.dart';
import 'package:app/routes/route_generator.dart';
import 'package:cron/cron.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.delete(key: 'userSession');
    await storage.delete(key: 'currentUser');
    return Future.value(true);
  });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false , // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  Workmanager().registerPeriodicTask(
    "end-session",
    "Session ended",
    frequency:const Duration(hours: 2),
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
