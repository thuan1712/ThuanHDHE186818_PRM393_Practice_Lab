class Trailer {
  final String id;
  final String title;
  final String duration;

  const Trailer({
    required this.id,
    required this.title,
    this.duration = '2:30',
  });
}
