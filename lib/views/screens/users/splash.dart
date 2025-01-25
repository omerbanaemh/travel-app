
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/users/login.dart';

import 'authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void loginSharedPreferences() async {
    String? token = await getToken();
    if (token == ''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Authentication()), (route) => false);
    }
    else if (token == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Authentication()), (route) => false);
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      loginSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/logo.png'),),
      ),
    );
  }
}