import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';
import 'package:yemen_travel_guid/views/screens/users/register.dart';
import 'package:yemen_travel_guid/views/screens/users/widgets/login/brown_button.dart';
import 'package:yemen_travel_guid/views/screens/users/widgets/login/white_button.dart';
import 'login.dart';


class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(55.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/auth/map.png'),
                ),
                const Text('اليمن',style: TextStyle(color: Color(0xFF7B8A4B),fontSize: 36),),
                const Text('"بين عبق التاريخ،', style: TextStyle(color: AppColors.primary2, fontSize: 24),),
                const Text('جمال الطبيعة، وعمق الثقافة"',style: TextStyle(
                  color: AppColors.primary2,fontSize: 24,
                ),),
                const SizedBox(height: 70,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>  const Login()));
                  },
                    child: const BrownButton(text: 'تسجيل الدخول')),
                const SizedBox(height: 35,),
                InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Register()));
                  },
                    child: const WhiteButton(text: 'إنشاء حساب')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
