import 'package:flutter/material.dart';
import 'package:yemen_travel_guid/colors/app_colors.dart';

class WhiteButton extends StatefulWidget {
  final String text;
  const WhiteButton({super.key, required this.text});

  @override
  State<WhiteButton> createState() => _WhiteButtonState();
}

class _WhiteButtonState extends State<WhiteButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white ,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.primary2,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(child: Text(widget.text,style: TextStyle(color: AppColors.primary2 ,fontSize: 18,fontWeight: FontWeight.bold,),)),
    );
  }
}
