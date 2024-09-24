import 'package:final_assignment/core/common/colors.dart';
import 'package:flutter/material.dart';

class MenuSubMenu extends StatelessWidget {
  const MenuSubMenu({
    super.key,
    required this.text,
    this.textColor = Colors.black,
    required this.icon,
    this.iconColor = Colors.black,
    required this.press,
    this.value,
    this.onToggle,
  });

  final String text;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? press;
  final bool? value;
  final ValueChanged<bool>? onToggle;

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
              color: iconColor,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(color: textColor))),
            // const Icon(Icons.arrow_forward_ios),
            if (onToggle != null)
              Switch(
                value: value ?? false,
                onChanged: onToggle,
              ),
          ],
        ),
      ),
    );
  }
}
