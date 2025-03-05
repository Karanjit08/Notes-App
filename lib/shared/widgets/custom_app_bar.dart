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
        icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
        onPressed: onBackPressed,
      ),
      title: Text(
        title ?? "",
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      actions: [
        if (onDeletePressed != null) // Show only if provided
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.primaryContainer),
              onPressed: onDeletePressed,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
