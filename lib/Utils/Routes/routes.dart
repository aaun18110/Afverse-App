import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/Auth/forgot_pswd.dart';
import 'package:shopping_app/Screens/home.dart';
import 'package:shopping_app/Screens/Auth/login.dart';
import 'package:shopping_app/Screens/Auth/signup.dart';
import 'package:shopping_app/Utils/Routes/routes_name.dart';

class Routes {
  static Route<dynamic> generatesRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesName.loginScreeen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.signupScreeen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
        case RoutesName.productScreeen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
         case RoutesName.passwordScreeen:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                "404 Error",
              ),
            ),
          );
        });
    }
  }
}
