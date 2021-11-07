import 'package:coure_reg_admin/models/student.dart';
import 'package:coure_reg_admin/screens/authenticate/authenticate.dart';
import 'package:coure_reg_admin/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../caller_home_student.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Student>(context);

    if (user == null) {
      print("register");
      return Authenticate();
    } else {
      print("login");
      return CallerHomeStudent();
      // return MainPage();
    }
  }
}
