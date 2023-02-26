import 'package:fastfill_station_app/ui/auth/signup_page.dart';
import 'package:fastfill_station_app/ui/home/payment_transactions_page.dart';
import 'package:fastfill_station_app/ui/home/transactions_tab_page_company.dart';
import 'package:fastfill_station_app/ui/station/station_payment_result_page.dart';
import 'package:flutter/material.dart';

import '../model/otp/otp_verification_phone_body.dart';
import '../model/payment/station_payment_result_body.dart';
import '../model/station/station.dart';
import '../model/station/station_with_transactions_total.dart';
import '../model/user/reset_password_body.dart';
import '../ui/auth/login_page.dart';
import '../ui/auth/otp_validation_page.dart';
import '../ui/auth/reset_password_password_page.dart';
import '../ui/auth/reset_password_phone_number_page.dart';
import '../ui/contact_us/contact_us_page.dart';
import '../ui/home/home_page.dart';
import '../ui/language/language_page.dart';
import '../ui/profile/profile_page.dart';
import '../ui/settings/settings_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case StationPaymentResultPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => StationPaymentResultPage(stationPaymentResultBody: settings.arguments as StationPaymentResultBody,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case SignupPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => SignupPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case ContactUsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ContactUsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case ProfilePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ProfilePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );


      case LoginPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case ResetPassword_PhoneNumberPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ResetPassword_PhoneNumberPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case TransactionsTabPageCompany.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => TransactionsTabPageCompany(company: settings.arguments as StationWithTransactionsTotal,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case PaymentTransactionsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => PaymentTransactionsPage(company: settings.arguments as StationWithTransactionsTotal,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case ResetPassword_PasswordPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => ResetPassword_PasswordPage(resetPasswordBody: settings.arguments as ResetPasswordBody,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );


      case SettingsPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => SettingsPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case LanguagePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(forSettings: (settings.arguments != null) ? settings.arguments as bool : false,),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );


      case OTPValidationPage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => OTPValidationPage(otpVerificationPhoneBody: settings.arguments as OTPVerificationPhoneBody),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      case HomePage.route:
        return PageRouteBuilder( pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },);
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
    }
  }
}
