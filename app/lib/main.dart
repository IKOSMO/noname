import 'package:core/l10n/app_localizations.dart';
import 'package:feature_settings/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tools/providers/providers.dart';

// late final AppDatabase database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // database = AppDatabase();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final state = ref.watch(settingsNotifier);
    final notifier = ref.read(settingsNotifier.notifier);

    return MaterialApp.router(
      title: 'noname',
      themeMode: state.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.black,
        cardColor: const Color.fromARGB(221, 43, 43, 43),
        colorScheme: const ColorScheme.dark(
          surface: Colors.black,
          primary: Color.fromARGB(255, 146, 228, 194),
          secondary: Color.fromARGB(255, 182, 142, 226),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: const Color.fromARGB(221, 43, 43, 43),
        colorScheme: const ColorScheme.dark(
          surface: Colors.black,
          primary: Color.fromARGB(255, 146, 228, 194),
          secondary: Color.fromARGB(255, 182, 142, 226),
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      locale: state.locale,
      supportedLocales: notifier.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      routerConfig: router.config(),
    );
  }
}
