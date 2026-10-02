import 'package:flutter/material.dart';
import '../models/trailer.dart';

class TrailerItem extends StatelessWidget {
  final Trailer trailer;
  final VoidCallback onTap;

  const TrailerItem({
    super.key,
    required this.trailer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: const Icon(
          Icons.play_circle_fill_rounded,
          color: Colors.redAccent,
          size: 32,
        ),
        title: Text(
          trailer.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            trailer.duration,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
