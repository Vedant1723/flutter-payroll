import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/components/Auth/LoginPage.dart';
import 'package:payroll/components/Home/HomePage.dart';
import 'package:payroll/components/Onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? prefs;
  String? onBoarded;
  bool isBoarded = false;
  String? token;
  bool isAuth = false;

  Future<bool> checkSession() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    return true;
  }

  void navigate() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => !isBoarded
            ? Onboarding()
            : isAuth
                ? HomePage()
                : LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    initializePreference();
    checkSession().then((value) {
      if (value) {
        navigate();
      }
    });
  }

  Future<void> initializePreference() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      onBoarded = prefs?.getString('onBoarded');
      token = prefs?.getString("token");
      if (onBoarded != null) {
        isBoarded = true;
      }
      if (token != null) {
        isAuth = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Shimmer.fromColors(
            child: Center(
              child: Container(
                child: Text(
                  'Payroll',
                  style: TextStyle(
                      fontSize: 90.0,
                      fontFamily: 'Pacifico',
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 18.0,
                            color: Colors.black87,
                            offset: Offset.fromDirection(120, 12))
                      ]),
                ),
              ),
            ),
            baseColor: Colors.grey,
            highlightColor: Colors.white),
      ),
    );
  }
}
