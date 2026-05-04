import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'package:firebase_core/firebase_core.dart';

// Pastikan file ini sudah di-generate
import 'firebase_options.dart'; 

// Import Connector dan Firebase Data Connect
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'generated/simogura_connector.dart';

// Import Screens
import 'screens/auth/login_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/dashboard/dashboard_awal.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Konfigurasi Emulator Data Connect
  if (kDebugMode) {
    // Chrome/Web menggunakan localhost (127.0.0.1)
    // Android Emulator menggunakan 10.0.2.2
    String host = (kIsWeb || defaultTargetPlatform != TargetPlatform.android) 
        ? '127.0.0.1' 
        : '10.0.2.2';
    
    // PERBAIKAN: Tambahkan '.dataConnect' sebelum memanggil useDataConnectEmulator
    SimoguraConnectorConnector.instance.dataConnect.useDataConnectEmulator(host, 9399);
    
    print("Data Connect Emulator terhubung ke: $host:9399");
  }

  // 3. Pengaturan Orientasi
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  runApp(const SimoguraApp());
}

class SimoguraApp extends StatelessWidget {
  const SimoguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String initialRoute = '/onboarding';
    final Map<String, WidgetBuilder> routes = {
      '/onboarding': (context) => const OnboardingScreen(),
      '/login': (context) => const LoginScreen(),
      '/dashboard-awal': (context) => const DashboardAwal(),
    };

    if (kIsWeb) {
      return MaterialApp(
        title: 'SIMOGURA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: DeviceFrame(
              device: Devices.ios.iPhone13,
              isFrameVisible: true,
              screen: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.theme,
                initialRoute: initialRoute,
                routes: routes,
              ),
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      title: 'SIMOGURA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: initialRoute,
      routes: routes,
    );
  }
}