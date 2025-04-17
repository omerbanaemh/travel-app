import 'package:flutter/material.dart';

import '../login/login_buttuon.dart';

class FormUser extends StatefulWidget {
  final GlobalKey<FormState> formKey ;
  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirmation;

  const FormUser({super.key, required this.formKey, required this.userName, required this.email, required this.password, required this.passwordConfirmation});

  @override
  State<FormUser> createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  @override
  Widget build(BuildContext context) {
     return Form(
      key: widget.formKey,
        child: Column(
          children: [
            LoginButton(
              icon: const Icon(Icons.person,color: Color(0xFFC08759),),
              label: 'اسم المستخدم',
              validator: 'required',
              controller: widget.userName,
            ),
            const SizedBox(height: 30),
            LoginButton(
              icon: const Icon(Icons.email,color: Color(0xFFC08759),),
              label: 'البريد الإلكتروني',
              validator: 'email',
              controller: widget.email,
            ),
            const SizedBox(height: 30),
            LoginButton(
                icon: const Icon(Icons.password,color: Color(0xFFC08759),),
                label: 'كلمة المرور',
                validator: 'password',
                controller: widget.password,
            ),
            const SizedBox(height: 30),
            LoginButton(
                icon: const Icon(Icons.password,color: Color(0xFFC08759),),
                label: 'تاكيد كلمة المرور',
                validator: '',
                controller: widget.passwordConfirmation,
            ),
            const SizedBox(height: 120),
          ],
        )
    );
  }
}
