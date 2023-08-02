import 'package:flutter/material.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/views/bottom_nav/main_bottom_nav.dart';
import 'package:student_link/views/bottom_nav/profilo/menu/change_password.dart';
import 'package:student_link/views/bottom_nav/profilo/menu/delete_account.dart';
import 'package:student_link/views/bottom_nav/profilo/menu/log_out.dart';
import 'package:student_link/views/chat/main_chat.dart';
import 'package:student_link/views/login/login_page.dart';
import 'package:student_link/views/login/login_signin.dart';
import 'package:student_link/views/login/reset_password/password_dimenticata_page.dart';
import 'package:student_link/views/on_boarding/on_boarding_page.dart';
import 'package:student_link/views/signin/signin_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF03A9F4),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
          },
        ),
      ),
      routes: {
        RouteNames.login_signin: (context) => const LoginSigninPage(),
        RouteNames.login_page: (context) => LoginPage(),
        RouteNames.password_dimenticata_page: (context) =>
            PasswordDimenticataPage(),
        RouteNames.signin_page: (context) => SignInPage(),
        RouteNames.on_boarding: (context) => const OnBoarding(),
        RouteNames.main_bottom_nav: (context) => BottomNavigation(),
        RouteNames.delete_account: (context) => DeleteAccount(),
        RouteNames.log_out: (context) => LogOutPage(),
        RouteNames.change_password: (context) => ChangePasswordPage(),
        RouteNames.main_chat_page: (context) => MainChat(),
      },
      // Usa un FutureBuilder per gestire l'attesa dell'operazione asincrona
      home: FutureBuilder<String>(
        future: _getInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data == RouteNames.main_bottom_nav) {
              return BottomNavigation();
            } else {
              return const LoginSigninPage();
            }
          }
        },
      ),
    );

//TODO: VERIFICARE UPDATE PROFILO E COMPLETAMENTO DI ESSO
  }

  // Definisci un metodo privato per ottenere la route iniziale
  Future<String> _getInitialRoute() async {
    //String? token = await _authService.getToken();
    /* bool isTokenExpired = await _authService.isTokenExpired(); 

    return (token != null) //TODO: VERIFICARE PURE SE IL TOKEN è SCADUTO E QUINDI RIFARE IL LOGIN
        ? RouteNames.main_bottom_nav
        : RouteNames.login_signin;*/

    return RouteNames.login_signin;
  }
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T>? route,
      BuildContext? context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget? child) {
    return child!;
  }
}
