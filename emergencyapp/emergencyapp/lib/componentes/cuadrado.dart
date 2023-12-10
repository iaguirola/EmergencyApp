import 'package:flutter/material.dart';



class SquareTitle extends StatelessWidget {

  final String image;

  final Function()? onTap;

  const SquareTitle({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
    
        ),
    
        child: Text(image),
      ),
    );
  }
}