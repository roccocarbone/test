import 'package:flutter/material.dart';
import 'package:student_link/routings/routes.dart';
import 'package:student_link/views/bottom_nav/main_bottom_nav.dart';
import 'package:student_link/views/login/login_page.dart';
import 'package:student_link/views/login/login_signin.dart';
import 'package:student_link/views/login/password_dimenticata_page.dart';
import 'package:student_link/views/on_boarding/on_boarding_page.dart';
import 'package:student_link/views/signin/create_carrier_page.dart';
import 'package:student_link/views/signin/create_profile_page.dart';
import 'package:student_link/views/signin/insert_profile_page.dart';
import 'package:student_link/views/signin/personal_services_page.dart';
import 'package:student_link/views/signin/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //DEFINIAMO TUTTE LE ROTTE DELL'APP
      initialRoute: RouteNames.login_signin,
      routes: {
        RouteNames.login_signin: (context) => const LoginSigninPage(),
        RouteNames.login_page: (context) => const LoginPage(),
        RouteNames.password_dimenticata_page: (context) =>
            const PasswordDimenticataPage(),
        RouteNames.signin_page: (context) => SignInPage(),
        RouteNames.create_carrier_page: (context) => const CreateCarrierPage(),
        RouteNames.create_profile_page: (context) => const CreateProfilePage(),
        RouteNames.insert_profile_photo_page: (context) =>
            const InsertProfilePhotoPage(),
        RouteNames.personal_services_page: (context) =>
            const PersonalServicesPage(),
        RouteNames.on_boarding:(context) => const OnBoarding(),
        RouteNames.main_bottom_nav:(context) => BottomNavigation()
      },
      theme: ThemeData(
        primaryColor: const Color(0xFF03A9F4),

        //SETTO ANIMAZIONE DI DEFAULT PER CAMBIO SCHERMATE
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: NoTransitionsBuilder(),
            TargetPlatform.iOS: NoTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}

//TODO
//CLASSE MOMENTANEA PER RIMUOVERE ANIMAZIONE DI CAMBIO SCHERMATA
class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}
