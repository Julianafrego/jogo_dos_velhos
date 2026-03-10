import 'package:flutter/material.dart';

class QuadradoTabuleiroWidget extends StatelessWidget {
  final String filling;
  final VoidCallback? onTap;

  const QuadradoTabuleiroWidget({
    super.key,
    required this.filling,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double tamanho = width / 4.5;
    final Color corBorda = Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: tamanho,
        height: tamanho,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: corBorda),
        ),
        child: Text(
          filling,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: corBorda,
          ),
        ),
      ),
    );
  }
}