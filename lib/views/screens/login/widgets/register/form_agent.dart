import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';

import '../login/login_buttuon.dart';

class FormAgent extends StatefulWidget {
  final GlobalKey<FormState> formkey ;
  final TextEditingController userName;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController password_confirmation;
  final TextEditingController phone;
  final TextEditingController officeName;
  final TextEditingController officePhone;
  final TextEditingController recordNumber;


  const FormAgent({super.key, required this.formkey, required this.userName, required this.email, required this.password, required this.password_confirmation, required this.phone, required this.officeName, required this.officePhone, required this.recordNumber});

  @override
  State<FormAgent> createState() => _FormAgentState();
}

class _FormAgentState extends State<FormAgent> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
        child: Column(
          children: [
            LoginButton(
              icon: Icon(Icons.person,color: AppColors.primary2,),
              label: 'اسم الوكيل',
              validator: '',
              controller: widget.userName,
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.email,color: AppColors.primary2,),
                label: 'البريد الإلكتروني',
                validator: 'email',
                controller: widget.email,
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'كلمة المرور',
                validator: 'password',
                controller: widget.password,
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.password,color: AppColors.primary2,),
                label: 'تاكيد كلمة المرور',
                validator: 'password',
                controller: widget.password_confirmation
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.phone_android,color: AppColors.primary2,),
                label: 'رقم الهاتف',
                validator: 'required',
                controller: widget.phone
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.home_work_outlined,color: AppColors.primary2,),
                label: 'اسم المكتب',
                validator: 'required',
                controller: widget.officeName
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.phone,color: AppColors.primary2,),
                label: 'رقم المكتب',
                validator: 'required',
                controller: widget.officePhone
            ),
            SizedBox(height: 10),
            LoginButton(
                icon: Icon(Icons.numbers,color: AppColors.primary2,),
                label: 'رقم السجل',
                validator: 'required',
                controller: widget.recordNumber
            ),
            SizedBox(height: 30),
          ],
        )
    );
  }
}
