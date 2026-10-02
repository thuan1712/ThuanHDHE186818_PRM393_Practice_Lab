import '../models/movie.dart';
import '../models/trailer.dart';

final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Dune: Part Two',
    posterUrl:
        'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500&auto=format&fit=crop&q=80',
    backdropUrl:
        'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=1200&auto=format&fit=crop&q=80',
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: const [
      Trailer(id: 't1', title: 'Official Trailer #1', duration: '2:24'),
      Trailer(id: 't2', title: 'IMAX Sneak Peek', duration: '3:15'),
    ],
  ),
  Movie(
    id: '2',
    title: 'Deadpool & Wolverine',
    posterUrl:
        'https://images.unsplash.com/photo-1563089145-599997674d42?w=500&auto=format&fit=crop&q=80',
    backdropUrl:
        'https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?w=1200&auto=format&fit=crop&q=80',
    overview:
        'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: const [
      Trailer(id: 't3', title: 'Red Band Trailer', duration: '2:38'),
      Trailer(id: 't4', title: 'Behind the Scenes', duration: '4:12'),
    ],
  ),
  Movie(
    id: '3',
    title: 'Oppenheimer',
    posterUrl:
        'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=500&auto=format&fit=crop&q=80',
    backdropUrl:
        'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1200&auto=format&fit=crop&q=80',
    overview:
        'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb during World War II.',
    genres: ['Biography', 'Drama', 'History'],
    rating: 8.9,
    trailers: const [
      Trailer(id: 't5', title: 'Official Trailer', duration: '3:05'),
      Trailer(id: 't6', title: 'Opening Look Preview', duration: '5:00'),
    ],
  ),
  Movie(
    id: '4',
    title: 'Spider-Man: Across the Spider-Verse',
    posterUrl:
        'https://images.unsplash.com/photo-1635805737707-575885ab0820?w=500&auto=format&fit=crop&q=80',
    backdropUrl:
        'https://images.unsplash.com/photo-1604200213928-ba3cf4fc8436?w=1200&auto=format&fit=crop&q=80',
    overview:
        'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.',
    genres: ['Animation', 'Action', 'Adventure'],
    rating: 8.7,
    trailers: const [
      Trailer(id: 't7', title: 'Teaser Trailer', duration: '2:15'),
      Trailer(id: 't8', title: 'Official Trailer #2', duration: '2:40'),
    ],
  ),
  Movie(
    id: '5',
    title: 'Interstellar',
    posterUrl:
        'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=500&auto=format&fit=crop&q=80',
    backdropUrl:
        'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=1200&auto=format&fit=crop&q=80',
    overview:
        'When Earth becomes uninhabitable in the future, a farmer and ex-NASA pilot, Joseph Cooper, is tasked to pilot a spacecraft to find a new planet for humans.',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    rating: 8.7,
    trailers: const [
      Trailer(id: 't9', title: 'Official Teaser', duration: '1:52'),
      Trailer(id: 't10', title: 'Final Trailer', duration: '2:34'),
    ],
  ),
];
