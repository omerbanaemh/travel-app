import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/login/introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  void loginSharedPreferences() async {
    print('=========loginSharedPreferences=========');
    String? token = await getToken();
    if (token == ''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const IntroScreen()), (route) => false);
    }
    else if (token == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const IntroScreen()), (route) => false);
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    super.initState();
    loginSharedPreferen();
    // Timer(const Duration(seconds: 3), () {
    //   loginSharedPreferences();
    // });
  }

void loginSharedPreferen()async{
              final Uri url = Uri.parse('https://wa.me/+967770051363?text=hello');
                await launchUrl(url);
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