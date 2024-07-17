import 'package:flutter/material.dart';
import 'package:tobe_mart/page/home_page.dart'; // Correct import
import 'package:tobe_mart/page/login_page.dart'; // Correct import
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const TobeStore());
}

class TobeStore extends StatelessWidget {
  const TobeStore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/loginpage',
      routes: {
        '/loginpage': (context) => const LoginPage(),
        '/homepage': (context) => const HomePage(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(
              child: Text('Route not found: ${settings.name}'),
            ),
          ),
        );
      },
    );
  }
}
