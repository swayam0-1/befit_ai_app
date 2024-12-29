
import 'package:befit_ai_app/tst/ex.dart';
import 'package:befit_ai_app/view/Screens/exercise/workout_onboard.dart';
import 'package:befit_ai_app/view/Screens/home_screen.dart';
import 'package:befit_ai_app/view/Screens/news_screen.dart';
import 'package:befit_ai_app/view/Screens/onboarding_screen.dart';
import 'package:befit_ai_app/view/Screens/workout_screen.dart';
import 'package:befit_ai_app/view/auth/login_screen.dart';
import 'package:befit_ai_app/view/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase has been initialized successfully.');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:OnboardingScreen(),
    );
  }
}
