import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/models/auth/user_model.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/login/register.dart';
import 'package:yemen_travel_guid/views/screens/login/widgets/login/brown_button.dart';
import 'package:yemen_travel_guid/views/screens/login/widgets/login/login_buttuon.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yemen_travel_guid/constant.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading = false;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();








  void handelLogin() async {
    setState(() {
      loading = true;
    });
    var response = await login(email.text, password.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data);
    } else {
      setState(() {
        loading = false;
      });
      showErrorSnackBar(context: context, message: response.error.toString(), );
    }
  }

  void _saveAndRedirectToHome(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id);
    await pref.setString('user', jsonEncode(user.toJson()));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              child: SvgPicture.asset(
                'assets/images/login/1.svg',
                width: width,
                // fit: BoxFit.cover,
              )
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/login/2.svg',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 187,
                      height: 192,
                    ),

                    Form(
                      key: formkey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 65),
                        child: Column(
                          children: [
                            LoginButton(
                              icon:const Icon(Icons.person,color: Color(0xFFC08759),),
                              label: "البريد الإلكتروني",
                              validator: 'email',
                              controller: email,),
                            const SizedBox(height: 30),
                            LoginButton(
                              icon:const Icon(Icons.password,color: Color(0xFFC08759),),
                              label: "كلمة المرور",
                              validator: 'password',
                              controller: password,
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => const Register()));
                                  },
                                  child: const Text(
                                    "ليس لدي حساب !",
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),


                            const SizedBox(height: 80),
                            InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()){
                                  handelLogin();
                                }

                              },
                              child: loading ?  const BrownButton( text: 'تسجيل الدخول',loading: true) :  const BrownButton( text: 'تسجيل الدخول'),
                            ),


                          ],
                        ),
                      ),
                    )


                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}