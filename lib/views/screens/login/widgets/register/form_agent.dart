import 'package:flutter/material.dart';

import '../login/login_buttuon.dart';

class FormAgent extends StatefulWidget {
  final GlobalKey<FormState> formKey ;
  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController passwordConfirmation;
  final TextEditingController phone;
  final TextEditingController officeName;
  final TextEditingController officePhone;
  final TextEditingController recordNumber;


  const FormAgent({super.key, required this.formKey, required this.userName, required this.email, required this.password, required this.passwordConfirmation, required this.phone, required this.officeName, required this.officePhone, required this.recordNumber});

  @override
  State<FormAgent> createState() => _FormAgentState();
}

class _FormAgentState extends State<FormAgent> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
        child: Column(
          children: [
            LoginButton(
              icon: const Icon(Icons.person,color: Color(0xFFC08759),),
              label: 'اسم الوكيل',
              validator: '',
              controller: widget.userName,
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.email,color: Color(0xFFC08759),),
                label: 'البريد الإلكتروني',
                validator: 'email',
                controller: widget.email,
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.password,color: Color(0xFFC08759),),
                label: 'كلمة المرور',
                validator: 'password',
                controller: widget.password,
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.password,color: Color(0xFFC08759),),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: widget.passwordConfirmation
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.phone_android,color: Color(0xFFC08759),),
                label: 'رقم الهاتف',
                validator: 'required',
                controller: widget.phone
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.home_work_outlined,color: Color(0xFFC08759),),
                label: 'اسم المكتب',
                validator: 'required',
                controller: widget.officeName
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.phone,color: Color(0xFFC08759),),
                label: 'رقم المكتب',
                validator: 'required',
                controller: widget.officePhone
            ),
            const SizedBox(height: 10),
            LoginButton(
                icon: const Icon(Icons.numbers,color: Color(0xFFC08759),),
                label: 'رقم السجل',
                validator: 'required',
                controller: widget.recordNumber
            ),
            const SizedBox(height: 30),
          ],
        )
    );
  }
}
