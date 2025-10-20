import 'package:flutter/material.dart';

Widget MenuList({
  required String title,
  required String file,
}) => Container(
  width: 372,
  height: 58,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [BoxShadow(offset: Offset(0, 1), blurRadius: 2)],
    color: Colors.white,
  ),

  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const SizedBox(width: 24),
          SizedBox(width: 48, height: 48, child: 
          Image.asset("assets/$file")
          ),

          SizedBox(width: 10),

          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),

      IconButton(
        onPressed: () {},
        icon: Icon(Icons.keyboard_arrow_right_rounded),
      ),
    ],
  ),
);
