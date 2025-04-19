import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/constant.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/login/introduction_screen/introduction_screen.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // دالة تتحقق من وجود رمز (token) للمستخدم في التخزين المحلي
  void loginSharedPreferences() async {
    String? token = await getToken();
    if (token == null || token.isEmpty){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const IntroScreen()), (route) => false);
    }
    else {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Home()), (route) => false);
    }
  }


  @override
  void initState() {
    // استدعاء فحص الـ token عند بداية التشغيل
    loginSharedPreferences();
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}