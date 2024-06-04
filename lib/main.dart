import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/screen/search_screen.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              background:
                  Color.fromARGB(255, 172, 225, 175), // Warna latar belakang
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          backgroundColor: Color.fromARGB(255, 172, 225, 175), // Warna AppBar
        ),
        primarySwatch: Colors.blue,
        textTheme: ThemeData().textTheme.apply(
              bodyColor: Colors.white, // Ubah warna teks menjadi putih
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MainScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
