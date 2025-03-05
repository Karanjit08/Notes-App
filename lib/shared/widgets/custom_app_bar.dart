import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback onBackPressed;
  final VoidCallback? onDeletePressed; // Optional delete action

  const CustomAppBar({
    Key? key,
    this.title,
    required this.onBackPressed,
    this.onDeletePressed, // Can be null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: onBackPressed,
      ),
      title: Text(
        title ?? "",
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: HexColor('#F8EEE2'),
      actions: [
        if (onDeletePressed != null) // Show only if provided
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.delete, color: HexColor('#d9614c')),
              onPressed: onDeletePressed,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
