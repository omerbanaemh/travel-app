import 'package:flutter/material.dart';


class BrownButton extends StatefulWidget {
  final bool loading;
  final String text;
  const BrownButton({super.key, required this.text,  this.loading = false,});

  @override
  State<BrownButton> createState() => _BrownButtonState();
}

class _BrownButtonState extends State<BrownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFA87247) ,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
          child: widget.loading ? const CircularProgressIndicator(color: Colors.white,) : Text(widget.text,style: const TextStyle(color: Colors.white ,fontSize: 18,fontWeight: FontWeight.bold,),)
      ),
    );
  }
}
