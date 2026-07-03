import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const LensMateApp());
}

class LensMateApp extends StatelessWidget {
  const LensMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '光影志',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const AppRouter(),
    );
  }
}
