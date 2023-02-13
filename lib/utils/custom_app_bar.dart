import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/string_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.color = AppColors.primaryColor,
    this.centerTitle = false,
    this.leading,
  }) : super(key: key);

  final String title;
  final Color color;
  final bool centerTitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 16),
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
