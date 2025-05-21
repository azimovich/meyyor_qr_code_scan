import 'package:flutter/material.dart';

class BottomSheetButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData iconData;
  const BottomSheetButton({super.key, required this.title, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: onPressed,
    );
  }
}
