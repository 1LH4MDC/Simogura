import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'package:simogura/screens/auth/login_screen.dart';
import 'core/theme/app_theme.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/dashboard/dashboard_awal.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Paksa orientasi portrait (hanya berlaku di mobile)
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  runApp(const SimoguraApp());
}

class SimoguraApp extends StatelessWidget {
  const SimoguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'SIMOGURA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/dashboard-awal': (context) => const DashboardAwal(),
        // '/login' tambahkan nanti
      },
    );

    // Kalau di Chrome/Web, bungkus dengan frame HP
    if (kIsWeb) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey[300], // background luar frame
          body: Center(
            child: DeviceFrame(
              device: Devices.ios.iPhone13,
              isFrameVisible: true,
              screen: app,
            ),
          ),
        ),
      );
    }

    // Kalau di HP asli, tampil normal
    return app;
  }
}