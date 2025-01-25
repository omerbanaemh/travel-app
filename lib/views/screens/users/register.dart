import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yemen_travel_guid/controllers/user_controller.dart';
import 'package:yemen_travel_guid/cor/util/snackbar_message.dart';
import 'package:yemen_travel_guid/models/api_response.dart';
import 'package:yemen_travel_guid/models/auth/user_model.dart';
import 'package:yemen_travel_guid/views/home.dart';
import 'package:yemen_travel_guid/views/screens/users/widgets/login/brown_button.dart';
import 'package:yemen_travel_guid/views/screens/users/widgets/register/form_agent.dart';
import 'package:yemen_travel_guid/views/screens/users/widgets/register/form_user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();
  TextEditingController userName =  TextEditingController();
  TextEditingController email =  TextEditingController();
  TextEditingController password =  TextEditingController();
  TextEditingController passwordConfirmation =  TextEditingController();
  TextEditingController phone =  TextEditingController();
  TextEditingController officeName =  TextEditingController();
  TextEditingController officePhone =  TextEditingController();
  TextEditingController recordNumber =  TextEditingController();


  bool loading = false;
  bool  selected = false;



  Future<void> _registerUser() async {
    setState(() {
      loading = true;
    });
    ApiResponse response = await registerUser(
        userName.text,
        email.text,
        password.text,
        passwordConfirmation.text,
    );
    print('1111111333331111111');

    if (response.error == null) {
      // _saveAndRedirectToHome(response.data as UserModel);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
    } else {
      showErrorSnackBar(context:context,message:response.error.toString());
    }
    setState(() {
      loading = false;
    });
  }


  void _registerAgent() async {
    print('11111111111111');
    setState(() {
      loading = true;
    });
    ApiResponse response = await registerAgent(
        userName.text,
        email.text,
        password.text,
        passwordConfirmation.text,
        officeName.text,
        officePhone.text,
        phone.text,
        recordNumber.text,
    );
    print('1111111333331111111');

    if (response.error == null) {
      // _saveAndRedirectToHome(response.data as UserModel);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
                (route) => false);
    } else {
      showErrorSnackBar(context:context,message:response.error.toString());
    }
    setState(() {
      loading = false;
    });
  }

  // Save and redirect to home
  // void _saveAndRedirectToHome(UserModel user) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   await pref.setString('token', user.token ?? '');
  //   await pref.setInt('userId', user.id);
  //   await pref.setString('user', jsonEncode(user.toJson()));
  //   Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => const Home()),
  //           (route) => false);
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/images/register/1.svg',
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              'assets/images/register/2.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: !selected
                                  ? Color(0xFFA87047)
                                  : Colors.grey,
                            ),
                            height: 35,
                            width: 105,
                            child: Center(
                              child: Text(
                                'تسجيل مستخدم',
                                style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selected = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selected
                                  ? Color(0xFFA87047)
                                  : Colors.grey,
                            ),
                            height: 35,
                            width: 105,
                            child: Center(
                              child: Text(
                                'تسجيل وكيل',
                                style: TextStyle(fontSize: 14, color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    selected ?
                    FormAgent(
                      userName: userName,
                      email: email,
                      password: password,
                      password_confirmation: passwordConfirmation,
                      phone: phone,
                      officeName: officeName,
                      officePhone: officePhone,
                      recordNumber: recordNumber,
                      formkey: formkey2,
                    ):
                    FormUser(
                      userName: userName,
                      email: email,
                      password: password,
                      password_confirmation: passwordConfirmation,
                      formkey: formkey,
                    ),





                    InkWell(
                        onTap: (){
                          if ( selected? formkey2.currentState!.validate() : formkey.currentState!.validate()){
                           // selected ?  _registerUser() : _registerAgent();
                           selected ?  _registerAgent() : _registerUser();
                          }
                        },
                        child: loading ?  BrownButton( text: 'إنشاء حساب',loading: true) :  BrownButton( text: 'إنشاء حساب'),
                    ),
                ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }


  // void _listener(BuildContext context, AuthState state) {
  //   if (state is RegisterSuccessfullyAuthState) {
  //     // Navigator.push(
  //     //     context,
  //     //     MaterialPageRoute(
  //     //         builder: (_) => const Home()));
  //     SnackBarMessage().showSuccessSnackBar(message: state.message, context: context);
  //   } else if (state is RegisterErrorAuthState && state.failure.message != null) {
  //     SnackBarMessage().showErrorSnackBar(message: state.failure.message!, context: context);
  //   }
  // }
}
