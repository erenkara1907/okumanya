import 'package:flutter/material.dart';

class CircularBookIcon extends StatelessWidget {
  final double size;
  final Color borderColor;
  final double borderWidth;
  final String? assetPath;

  const CircularBookIcon({
    super.key,
    this.size = 45,
    this.borderColor = const Color(0xFF4ECDC4),
    this.borderWidth = 1,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: Color(0xFF1E3A8A),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(size * 0.2),
          child: assetPath != null
              ? Image.asset(
                  assetPath!,
                  fit: BoxFit.contain,
                )
              : Icon(
                  Icons.menu_book_rounded,
                  size: size * 0.4,
                  color: Colors.orange,
                ),
        ),
      ),
    );
  }
}
