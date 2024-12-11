import 'dart:async';
import 'package:fit_ratio/main.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget{
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage(title: 'Fit Ratio')));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: const Color(0xFF5271ff),
      child: Image.asset('assets/Images/Logo.png',
      ),
    );
  }
}