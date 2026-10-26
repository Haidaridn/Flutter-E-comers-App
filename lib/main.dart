import 'package:e_comers_app/pages/account_page.dart';
import 'package:e_comers_app/pages/change_password.dart';
import 'package:e_comers_app/pages/detail_chart.dart';
import 'package:e_comers_app/pages/home_page.dart';
import 'package:e_comers_app/pages/list_chat.dart';
import 'package:e_comers_app/pages/login_page.dart';
import 'package:e_comers_app/pages/register_page.dart';
import 'package:e_comers_app/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AURA — Curated Store',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginPage(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/signup_page': (context) => const RegisterPage(),
        '/home_page': (context) => const HomePage(),
        '/account_page': (context) => const AccountPage(),
        '/change_password_page': (context) => const ChangePasswordPage(),
        '/list_chat_page': (context) => const ChatListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name != '/detail_chat') {
          return null;
        }

        final arguments = settings.arguments;
        final contactNameValue = arguments is Map<String, dynamic>
            ? arguments['contactName']
            : null;
        final contactName = contactNameValue is String
            ? contactNameValue
            : null;

        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => ChatScreen(
            contactName: contactName?.trim().isNotEmpty == true
                ? contactName!
                : 'Penjual',
          ),
        );
      },
    );
  }
}
