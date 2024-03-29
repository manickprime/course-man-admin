import 'package:coure_reg_admin/screens/authenticate/login_screen.dart';
import 'package:coure_reg_admin/screens/authenticate/registration_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return LoginScreen(toggleView: toggleView);
    else
      return RegistrationScreen(toggleView: toggleView);
  }
}
