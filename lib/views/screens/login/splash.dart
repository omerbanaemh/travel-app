import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/home.dart';
<<<<<<<< HEAD:lib/views/screens/login/splash.dart
import 'package:yemen_travel_guid/views/screens/login/introduction_screen/introduction_screen.dart';
import 'package:url_launcher/url_launcher.dart';
========
import 'package:yemen_travel_guid/views/screens/login/splash.dart';
>>>>>>>> 40357ff9e0e030d2706f731afe7dfa5f131b7ac1:lib/loading.dart



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  void loginSharedPreferences() async {
    print('=========loginSharedPreferences=========');
    String? token = await getToken();
    if (token == ''){
<<<<<<<< HEAD:lib/views/screens/login/splash.dart
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const IntroScreen()), (route) => false);
    }
    else if (token == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const IntroScreen()), (route) => false);
========
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
    }
    else if (token == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
>>>>>>>> 40357ff9e0e030d2706f731afe7dfa5f131b7ac1:lib/loading.dart
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    super.initState();
<<<<<<<< HEAD:lib/views/screens/login/splash.dart
    loginSharedPreferen();
    // Timer(const Duration(seconds: 3), () {
    //   loginSharedPreferences();
    // });
========
      loginSharedPreferences();
>>>>>>>> 40357ff9e0e030d2706f731afe7dfa5f131b7ac1:lib/loading.dart
  }

void loginSharedPreferen()async{
              final Uri url = Uri.parse('https://wa.me/+967770051363?text=hello');
                await launchUrl(url);
}


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}