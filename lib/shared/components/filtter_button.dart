import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  Color color ;
  Color color2 ;

   FilterButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.color2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12,color: color2),
            ),
            SizedBox(width: 8),
            Image.asset("assets/icons/down+arrow.png"),
          ],
        ),
      ),
    );
  }
}
