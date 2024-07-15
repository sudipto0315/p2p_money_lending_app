import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:p2p_money_lending_app/common/color_extension.dart';
import 'package:p2p_money_lending_app/view/login/welcome_view.dart';
import 'package:p2p_money_lending_app/view/borrower/main_tab/main_tab_view.dart';
import 'package:p2p_money_lending_app/view/lender/main_tab/main_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Ensure system UI overlay styles are set before the app runs
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
    statusBarIconBrightness: Brightness.light, // Status bar icons brightness
    systemNavigationBarColor: Colors.black, // Navigation bar color
    systemNavigationBarIconBrightness: Brightness.light, // Navigation bar icons brightness
  ));

  // Set system UI mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'P2P Money App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Inter",
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primary,
          surface: TColor.gray80,
          primary: TColor.primary,
          primaryContainer: TColor.gray60,
          secondary: TColor.secondary,
        ),
        useMaterial3: false,
      ),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return const WelcomeView(); // No SharedPreferences instance found, show WelcomeView
            }
            final prefs = snapshot.data!;
            final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
            if (isLoggedIn) {
              final email = prefs.getString('userEmail') ?? '';
              final role = prefs.getString('userRole') ?? '';
              // Depending on the role, navigate to the appropriate view
              if (role == 'borrower') {
                return BorrowerMainTabView(email: email, role: role);
              } else if (role == 'lender') {
                return LenderMainTabView(email: email, role: role);
              } else {
                return const WelcomeView(); // Role not recognized, show WelcomeView
              }
            } else {
              return const WelcomeView(); // Not logged in, show WelcomeView
            }
          }
          return const Center(child: CircularProgressIndicator()); // Waiting for SharedPreferences to load
        },
      ),
    );
  }
}