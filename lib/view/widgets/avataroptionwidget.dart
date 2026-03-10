import 'package:flutter/material.dart';

class AvatarOptionWidget extends StatelessWidget {
  final String avatarPath;
  final bool selecionado;
  final VoidCallback onTap;

  const AvatarOptionWidget({
    super.key,
    required this.avatarPath,
    required this.selecionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selecionado
                ? const Color.fromARGB(255, 210, 148, 5)
                : Colors.grey,
            width: selecionado ? 3 : 1.5,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            avatarPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}