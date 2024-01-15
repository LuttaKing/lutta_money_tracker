// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lutta_money_tracker/utils/constants.dart';
import 'package:lutta_money_tracker/widgets/app_button.dart';
import 'package:lutta_money_tracker/widgets/app_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(padding: EdgeInsets.all(defaultPadding),
      child: ListView(children: [

        Center(child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text('Lutt Money Tracker',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),),
        )),

        DefaultAppTextField(hintText: 'Email',autofocus: true,),

        DefaultAppTextField(hintText: 'Password'),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: AppButton(name: 'LOG IN',onTap: (){},),
        ),

      ]),
      ),
    );
  }
}