import 'package:flutter/material.dart';
import './themes/theme.dart';
import 'screens/dashboard_screen.dart';
import 'widgets/take_charge_detail.dart';
import 'screens/punch_record_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academate',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/take_charge_detail': (context) => const TakeChargeDetail(),
        '/punch_record': (context) => PunchRecordScreen(),
      },
    );
  }
}
