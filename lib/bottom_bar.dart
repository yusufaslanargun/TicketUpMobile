import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final VoidCallback onHistoryTap;
  final VoidCallback onFormTap;
  final VoidCallback onScanTap;

  const BottomBar({
    Key? key,
    required this.onHistoryTap,
    required this.onFormTap,
    required this.onScanTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF444444),
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: onHistoryTap,
          ),
          const SizedBox(width: 40), // Space for FAB
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: onFormTap,
          ),
        ],
      ),
    );
  }
}
