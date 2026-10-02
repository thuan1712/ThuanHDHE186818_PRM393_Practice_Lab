import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../widgets/hero_banner.dart';
import '../widgets/action_button.dart';
import '../widgets/trailer_item.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late bool _isFavorite;
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.movie.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      widget.movie.isFavorite = _isFavorite;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite
              ? 'Đã thêm "${widget.movie.title}" vào danh sách yêu thích!'
              : 'Đã xóa "${widget.movie.title}" khỏi danh sách yêu thích.',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showRatingDialog() {
    double tempRating = _userRating > 0 ? _userRating : widget.movie.rating;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Đánh giá phim',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.movie.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starIndex = index + 1;
                  return IconButton(
                    icon: Icon(
                      starIndex <= (tempRating / 2).round()
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 32,
                    ),
                    onPressed: () {
                      setDialogState(() {
                        tempRating = starIndex * 2.0;
                      });
                    },
                  );
                }),
              ),
              const SizedBox(height: 8),
              Text(
                '${tempRating.toStringAsFixed(1)} / 10.0 ⭐',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  _userRating = tempRating;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Cảm ơn bạn đã đánh giá: ${tempRating.toStringAsFixed(1)} sao!',
                    ),
                  ),
                );
              },
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      ),
    );
  }

  void _shareMovie() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang chia sẻ phim "${widget.movie.title}"...'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _playTrailer(String trailerTitle) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(Icons.movie_filter_outlined, color: Colors.redAccent),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    trailerTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 56,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Đang phát video trailer giả lập...',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Đóng'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Hero Banner (Stack + Image.network + gradient)
            HeroBanner(movie: widget.movie),

            const SizedBox(height: 16),

            // 2. Title & Genres (Wrap + Chip)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: widget.movie.genres.map((genre) {
                  return Chip(
                    label: Text(genre),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                    backgroundColor: theme.colorScheme.surfaceVariant,
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 12),

            // 3. Overview text with Padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.movie.overview,
                style: theme.textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(indent: 16, endIndent: 16),

            // 4. Row of IconButtons (Favorite, Rate, Share)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MovieActionButton(
                    icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
                    label: 'Favorite',
                    color: _isFavorite ? Colors.red : null,
                    onTap: _toggleFavorite,
                  ),
                  MovieActionButton(
                    icon: _userRating > 0 ? Icons.star : Icons.star_border,
                    label: _userRating > 0
                        ? '${_userRating.toStringAsFixed(1)}★'
                        : 'Rate',
                    color: _userRating > 0 ? Colors.amber[700] : null,
                    onTap: _showRatingDialog,
                  ),
                  MovieActionButton(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: _shareMovie,
                  ),
                ],
              ),
            ),

            const Divider(indent: 16, endIndent: 16),
            const SizedBox(height: 8),

            // 5. Section: Trailers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Trailers',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 6. Trailer list using ListView.builder
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.movie.trailers.length,
              itemBuilder: (context, index) {
                final trailer = widget.movie.trailers[index];
                return TrailerItem(
                  trailer: trailer,
                  onTap: () => _playTrailer(trailer.title),
                );
              },
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
