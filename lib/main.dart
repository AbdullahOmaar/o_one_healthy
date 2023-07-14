import 'package:app/routes/app_routes.dart';
import 'package:app/routes/route_generator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';
import 'package:workmanager/workmanager.dart';
import 'firebase_options.dart';
import 'util/constant.dart';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
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
    isInDebugMode:
        false, // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  Workmanager().registerPeriodicTask(
    "end-session",
    "Session ended",
    frequency: const Duration(hours: 2),
  );
  runApp(ProviderScope(
    child: EasyLocalization(
        supportedLocales: Lang.values.map((e) => Locale(e.name)).toList(),
        path: 'assets/translations',
        fallbackLocale: Locale(Lang.ar.name),
        startLocale: Locale(Lang.ar.name),
        child: DevicePreview(
            enabled: kReleaseMode, builder: (context) => const MyApp())),
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
    Workmanager().registerPeriodicTask(
      "end-session",
      "Session ended",
      frequency: const Duration(hours: 2),
    );
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
              primarySwatch: Themes.kPrimarySwatch,
              fontFamily: Themes.kFontFamily),
          initialRoute: getInitialPage(),
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }

  String getInitialPage() => AppRoutes.home;
}
