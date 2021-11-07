import 'package:coure_reg_admin/screens/main_page.dart';
import 'package:coure_reg_admin/screens/show_requests.dart';
import 'package:coure_reg_admin/screens/welcome_screen.dart';
import 'package:coure_reg_admin/screens/wrapper/wrapper_home.dart';
import 'package:flutter/material.dart';

import 'screens/authenticate/login_screen.dart';
import 'screens/authenticate/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LeavApp());
}

class LeavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WrapperHome.id,
      routes: {
        WrapperHome.id: (context) => WrapperHome(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        MainPage.id: (context) => MainPage(),
        ShowRequests.id: (context) => ShowRequests(),
      },
    );
  }
}
