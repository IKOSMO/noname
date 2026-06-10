import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noname/tools/providers/providers.dart';
import 'package:variable_blur/variable_blur.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await VariableBlur.precacheShaders();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(routerConfig: router.config());
  }
}
