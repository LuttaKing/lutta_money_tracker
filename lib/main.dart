import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lutta_money_tracker/controller/transactions_controller.dart';
import 'package:lutta_money_tracker/screens/app/home.dart';
import 'package:lutta_money_tracker/screens/auth/login.dart';
import 'package:lutta_money_tracker/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MultiProvider(
      providers: providerList,
      child: const MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lutta Money Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: backGroundColor,
        textTheme: GoogleFonts.karlaTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}


List<SingleChildWidget> get providerList {
  return [
    ChangeNotifierProvider (
      create: (context) => TransactionsNotifier(),
    ),
  
  ];
}
