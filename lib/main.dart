import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:device_frame/device_frame.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import Screens
import 'screens/auth/login_screen.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/dashboard/dashboard_awal.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://zhhegvwjahymqudoztso.supabase.co',
    anonKey: 'sb_publishable_7DrOWbtShGGvjb7UOce9iA_ZmAzN7YD',
  );

  // Orientation settings
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  runApp(const SimoguraApp());
}

class SimoguraApp extends StatelessWidget {
  const SimoguraApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String initialRoute = '/onboarding';
    final Map<String, WidgetBuilder> routes = {
      '/onboarding': (context) => const OnboardingScreen(),
      '/login': (context) => const LoginScreen(),
      '/dashboard-awal': (context) => const DashboardAwal(),
      '/todos': (context) => const TodosHomePage(), // Test route for the todos table
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

// Keeping the Todos page as a reference/test page from the provided code
class TodosHomePage extends StatefulWidget {
  const TodosHomePage({super.key});

  @override
  State<TodosHomePage> createState() => _TodosHomePageState();
}

class _TodosHomePageState extends State<TodosHomePage> {
  final _future = Supabase.instance.client
      .from('todos')
      .select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos Test'),
        backgroundColor: const Color(0xFF0C344D),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final todos = snapshot.data as List<dynamic>;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: ((context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo['name'] ?? 'No Name'),
              );
            }),
          );
        },
      ),
    );
  }
}
