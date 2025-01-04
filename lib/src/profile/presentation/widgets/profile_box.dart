import 'package:flutter/material.dart';

class ProfileBox extends StatefulWidget {
  const ProfileBox({
    required this.title,
    required this.icon,
    required this.color,
    required this.data,
    super.key,
  });
  final String title;
  final Icon icon;
  final Color color;
  final Object? data;

  @override
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          widget.icon,
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.data?.toString() ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
