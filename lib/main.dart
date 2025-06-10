import 'package:academate_faculty/screens/your_courses.dart';
import 'package:academate_faculty/widgets/course_card.dart';
import 'package:flutter/material.dart';
import './themes/theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/leave_history.dart';
import 'widgets/take_charge_detail.dart';
<<<<<<< HEAD
import 'package:flutter_riverpod/flutter_riverpod.dart';
=======
import 'screens/punch_record_screen.dart';
>>>>>>> f0bfd9e00a562d3947c26e83a09e2816b0975224

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
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => DashboardScreen(),
        '/take_charge_detail': (context) => const TakeChargeDetail(),
        '/punch_record': (context) => PunchRecordScreen(),
        '/your_courses': (context) => YourCourses(),
      },
    );
  }
}
