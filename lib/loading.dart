
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/login/splash.dart';



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void loginSharedPreferences() async {
    String? token = await getToken();
    if (token == ''){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
    }
    else if (token == null){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    super.initState();
      loginSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}