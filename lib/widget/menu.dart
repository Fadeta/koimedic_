import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function() onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 25, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "Urbanist",
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
