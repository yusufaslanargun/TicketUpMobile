import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller; // controller parametresi eklendi

  const InputBox({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required bool obscureText, // controller parametresi alındı
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // controller kullanıldı
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.transparent, // İç kısmı saydam yap
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white), // Kenar rengi beyaz
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white), // Kenar rengi beyaz
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white), // Kenar rengi beyaz
            ),
            hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5)), // Opak hint rengi
          ),
          style: const TextStyle(color: Colors.white), // Yazı rengi beyaz
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
