import 'package:flutter/material.dart';
import '../models/movie.dart';

class HeroBanner extends StatelessWidget {
  final Movie movie;

  const HeroBanner({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'banner-${movie.id}',
      child: Stack(
        children: [
          // Backdrop Image
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.network(
              movie.backdropUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: const Center(
                    child: Icon(
                      Icons.movie_outlined,
                      size: 64,
                      color: Colors.white54,
                    ),
                  ),
                );
              },
            ),
          ),

          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          // Title overlaid on gradient banner
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 4,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
