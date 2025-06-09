import 'package:flutter/material.dart';
import './themes/theme.dart'; // Import your custom theme
import 'screens/dashboard_screen.dart';
import 'screens/leave_history.dart';
import 'widgets/take_charge_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academate',
      debugShowCheckedModeBanner: false,
      theme: appTheme, // Use custom theme here
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/take_charge_detail': (context) => const TakeChargeDetail(),
      },
    );
  }
}
