import 'package:flutter/material.dart';


class LoginButton extends StatefulWidget {
  final Icon icon;
  final String label;
  final String validator;
  final TextEditingController controller;
  const LoginButton({super.key, required this.icon, required this.label, required this.controller, required this.validator, });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFDFE),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.visiblePassword,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          isDense: true,
          errorStyle: const TextStyle(
            color: Colors.red, // اللون الذي تريده
            height: 0.1, // تقليل المسافة العمودي
          ),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Color(0xFFCE9263)),
          prefixIcon: widget.icon,
          border: InputBorder.none,
        ),
        validator: widget.validator == 'email' ?
            (String? value) {
          if (value == null || value.isEmpty) {
            return "الرجاء إدخال بريدك الإلكتروني";
          }
          // قم بإنشاء تعبير عادي للتحقق من تنسيق البريد الإلكتروني
          final emailRegExp = RegExp(
            r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
          );
          if (!emailRegExp.hasMatch(value)) {
            return 'يرجى إدخال بريد إلكتروني صالح';
          }
          return null;
        }
        : widget.validator == 'password' ?
         (String? value) {
         if (value!.length < 6) {
         return "مطلوب ما لا يقل عن 6 أحرف";
         }
         return null;
         }: widget.validator == 'required' ?
            (String? value) {
          if (value == null || value.isEmpty) {
            return "الرجاء إدخال الحقل ";
          }
          return null;
        }: null,
      ),
    );
  }
}
