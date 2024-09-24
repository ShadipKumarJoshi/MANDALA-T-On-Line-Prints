import 'package:final_assignment/core/common/colors.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
  });

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: goldColor,
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: Colors.black,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: const TextStyle(color: Colors.black),
            )),
            // const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
