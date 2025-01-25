import 'package:flutter/material.dart';

import 'package:yemen_travel_guid/colors/app_colors.dart';
import '../login/login_buttuon.dart';

class FormUser extends StatefulWidget {
  final GlobalKey<FormState> formkey ;
  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController password_confirmation;

  const FormUser({super.key, required this.formkey, required this.userName, required this.email, required this.password, required this.password_confirmation});

  @override
  State<FormUser> createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  @override
  Widget build(BuildContext context) {
     return Form(
      key: widget.formkey,
        child: Column(
          children: [
            LoginButton(
                icon: Icon(Icons.email,color: AppColors.primary2,),
                label: 'البريد الإلكتروني',
                validator: 'email',
                controller: widget.email,
            ),
            SizedBox(height: 30),
            LoginButton(
                icon: Icon(Icons.person,color: AppColors.primary2,),
                label: 'اسم المستخدم',
                validator: 'required',
                controller: widget.userName,
            ),
            SizedBox(height: 30),
            LoginButton(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'كلمة المرور',
                validator: 'password',
                controller: widget.password,
            ),
            SizedBox(height: 30),
            LoginButton(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: '',
                controller: widget.password_confirmation,
            ),
            SizedBox(height: 120),
          ],
        )
    );
  }
}
