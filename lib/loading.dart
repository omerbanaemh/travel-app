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

  void checkAuthStatus() async {
    String? token = await getToken();
    if (token == null || token.isEmpty){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const SplashScreen()), (route) => false);
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    checkAuthStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}