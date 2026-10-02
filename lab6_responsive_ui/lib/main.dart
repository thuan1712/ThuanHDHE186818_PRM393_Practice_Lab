import 'package:flutter/material.dart';

// ============================================================================
// Lab 6: Building a Responsive Movie Genre Browsing Screen
// PRM393 - Lập trình Di động (Flutter)
// Sinh viên: Hoàng Đức Thuận - MSSV: HE186818
// Toàn bộ mã nguồn nằm gọn trong 1 file duy nhất, có thể chạy trực tiếp trên
// Android Studio, VS Code, hoặc copy-paste vào DartPad.
// ============================================================================

void main() {
  runApp(const ResponsiveMovieApp());
}

// ----------------------------------------------------------------------------
// Step 2: Data Model & Sample Data
// ----------------------------------------------------------------------------

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });

  String get genresText => genres.join(', ');
}

/// Danh sách dữ liệu phim mẫu đa dạng thể loại và năm phát hành
const List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl:
        'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500&auto=format&fit=crop&q=80',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy', 'Sci-Fi'],
    posterUrl:
        'https://images.unsplash.com/photo-1563089145-599997674d42?w=500&auto=format&fit=crop&q=80',
    rating: 8.3,
  ),
  Movie(
    title: 'Oppenheimer',
    year: 2023,
    genres: ['Drama', 'History', 'Biography'],
    posterUrl:
        'https://images.unsplash.com/photo-1440404653325-ab127d49abc1?w=500&auto=format&fit=crop&q=80',
    rating: 8.9,
  ),
  Movie(
    title: 'Spider-Man: Across the Spider-Verse',
    year: 2023,
    genres: ['Animation', 'Action', 'Adventure'],
    posterUrl:
        'https://images.unsplash.com/photo-1635805737707-575885ab0820?w=500&auto=format&fit=crop&q=80',
    rating: 8.7,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    posterUrl:
        'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=500&auto=format&fit=crop&q=80',
    rating: 8.7,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl:
        'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500&auto=format&fit=crop&q=80',
    rating: 9.0,
  ),
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Adventure'],
    posterUrl:
        'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?w=500&auto=format&fit=crop&q=80',
    rating: 8.8,
  ),
  Movie(
    title: 'Spirited Away',
    year: 2001,
    genres: ['Animation', 'Adventure', 'Family'],
    posterUrl:
        'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=500&auto=format&fit=crop&q=80',
    rating: 8.6,
  ),
];

// ----------------------------------------------------------------------------
// Step 3: Base Scaffold & App Entry
// ----------------------------------------------------------------------------

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const GenreScreen(),
    );
  }
}

// ----------------------------------------------------------------------------
// Main Screen: GenreScreen (Stateful Widget)
// ----------------------------------------------------------------------------

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // State variables
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A-Z';
  final TextEditingController _searchController = TextEditingController();

  // Danh sách các thể loại có sẵn để hiển thị các chip
  final List<String> _availableGenres = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Drama',
    'Family',
    'History',
    'Sci-Fi',
  ];

  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
      _selectedGenres.clear();
      _selectedSort = 'A-Z';
    });
  }

  void _showMovieDetails(Movie movie) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 90,
                    height: 125,
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.blueGrey[100],
                        child: const Icon(Icons.movie, size: 40),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Năm phát hành: ${movie.year}',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.rating} / 10.0',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: movie.genres.map((g) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              g,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(ctx),
                icon: const Icon(Icons.check),
                label: const Text('Đóng'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final isTabletOrWeb = screenWidth >= 800;
    // Nhận diện màn hình bị lùn (ví dụ điện thoại xoay ngang) để tinh chỉnh padding
    final isCompactHeight = screenHeight < 520;

    // Step 7: Filter and Sort visible movies
    List<Movie> visibleMovies = allMovies.where((movie) {
      final matchesSearch = _searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesGenre = _selectedGenres.isEmpty ||
          movie.genres.any((g) => _selectedGenres.contains(g));

      return matchesSearch && matchesGenre;
    }).toList();

    // Sorting
    visibleMovies.sort((a, b) {
      switch (_selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); // Newest first
        case 'Rating':
          return b.rating.compareTo(a.rating); // Highest first
        default:
          return 0;
      }
    });

    final hasActiveFilters =
        _searchQuery.isNotEmpty || _selectedGenres.isNotEmpty || _selectedSort != 'A-Z';

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletOrWeb ? 24.0 : 16.0,
            vertical: isCompactHeight ? 6.0 : 12.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --------------------------------------------------------------
              // Lab 6.1: Responsive Hero & Heading Section
              // --------------------------------------------------------------
              _buildHeaderSection(screenWidth, isTabletOrWeb, isCompactHeight),

              SizedBox(height: isCompactHeight ? 6 : 12),

              // --------------------------------------------------------------
              // Lab 6.2: Search Bar, Genre Chips & Sort Bar
              // --------------------------------------------------------------
              _buildSearchBar(isCompactHeight),

              SizedBox(height: isCompactHeight ? 6 : 10),

              _buildGenreChipsSection(isCompactHeight),

              SizedBox(height: isCompactHeight ? 4 : 8),

              _buildSortAndFilterStatus(visibleMovies.length, hasActiveFilters),

              SizedBox(height: isCompactHeight ? 4 : 6),

              // --------------------------------------------------------------
              // Lab 6.3: Responsive Movie List & Tablet Layout
              // --------------------------------------------------------------
              Expanded(
                child: _buildResponsiveMovieList(visibleMovies, isCompactHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Widget: Header Section (Hero & Title)
  // --------------------------------------------------------------------------
  Widget _buildHeaderSection(double screenWidth, bool isTabletOrWeb, bool isCompactHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find a Movie',
                style: TextStyle(
                  fontSize: isCompactHeight ? 22 : (isTabletOrWeb ? 30 : 25),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: -0.5,
                ),
              ),
              if (!isCompactHeight) ...[
                const SizedBox(height: 2),
                Text(
                  'Khám phá phim theo thể loại, năm & đánh giá',
                  style: TextStyle(
                    fontSize: isTabletOrWeb ? 14 : 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Icon / Badge báo chế độ hiển thị (Phone vs Tablet/Web)
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: isCompactHeight ? 4 : 6,
          ),
          decoration: BoxDecoration(
            color: isTabletOrWeb ? Colors.indigo[50] : Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isTabletOrWeb ? Colors.indigo.shade200 : Colors.blue.shade200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isTabletOrWeb ? Icons.tablet_mac_rounded : Icons.phone_android_rounded,
                size: 15,
                color: isTabletOrWeb ? Colors.indigo : Colors.blue[700],
              ),
              const SizedBox(width: 5),
              Text(
                isTabletOrWeb ? 'Tablet (2 Cột)' : 'Phone (1 Cột)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isTabletOrWeb ? Colors.indigo : Colors.blue[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Widget: Search Bar
  // --------------------------------------------------------------------------
  Widget _buildSearchBar(bool isCompactHeight) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.trim();
          });
        },
        decoration: InputDecoration(
          hintText: 'Nhập tên phim cần tìm kiếm...',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF1E88E5), size: 20),
          isDense: isCompactHeight,
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: isCompactHeight ? 8 : 12,
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------------------------
  // Widget: Genre Chips (Sử dụng Wrap tự động xuống dòng, hỗ trợ cuộn khi hẹp)
  // --------------------------------------------------------------------------
  Widget _buildGenreChipsSection(bool isCompactHeight) {
    final chips = _availableGenres.map((genre) {
      final isSelected = _selectedGenres.contains(genre);
      return FilterChip(
        label: Text(genre),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _selectedGenres.add(genre);
            } else {
              _selectedGenres.remove(genre);
            }
          });
        },
        selectedColor: const Color(0xFF1E88E5).withOpacity(0.15),
        checkmarkColor: const Color(0xFF1E88E5),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF1E88E5) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: isCompactHeight ? 11 : 12,
        ),
        backgroundColor: Colors.white,
        visualDensity: isCompactHeight ? VisualDensity.compact : VisualDensity.standard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: isSelected ? const Color(0xFF1E88E5) : Colors.grey.withOpacity(0.25),
          ),
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCompactHeight) ...[
          Row(
            children: [
              const Text(
                'Thể loại',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              if (_selectedGenres.isNotEmpty) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_selectedGenres.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
        ],

        // Nếu chiều cao lùn (Landscape Phone), cuộn ngang để không chiếm chiều cao
        if (isCompactHeight)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: chips.map((c) => Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: c,
              )).toList(),
            ),
          )
        else
          Wrap(
            spacing: 6.0,
            runSpacing: 4.0,
            children: chips,
          ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Widget: Sort Dropdown & Status Bar
  // --------------------------------------------------------------------------
  Widget _buildSortAndFilterStatus(int resultCount, bool hasActiveFilters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'Kết quả: $resultCount phim',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              if (hasActiveFilters) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: _clearFilters,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.close_rounded, size: 14, color: Colors.red[600]),
                        const SizedBox(width: 2),
                        Text(
                          'Xóa lọc',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.red[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        // Dropdown Sắp xếp (A-Z, Z-A, Year, Rating)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.sort_rounded, size: 16, color: Colors.grey),
            const SizedBox(width: 3),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSort,
                isDense: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black87, size: 20),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.circular(12),
                items: _sortOptions.map((opt) {
                  return DropdownMenuItem<String>(
                    value: opt,
                    child: Text('Sắp xếp: $opt'),
                  );
                }).toList(),
                onChanged: (newVal) {
                  if (newVal != null) {
                    setState(() {
                      _selectedSort = newVal;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --------------------------------------------------------------------------
  // Widget: Responsive Movie List (LayoutBuilder với Breakpoint 800px)
  // --------------------------------------------------------------------------
  Widget _buildResponsiveMovieList(List<Movie> movies, bool isCompactHeight) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'Không tìm thấy bộ phim phù hợp với bộ lọc',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: _clearFilters,
              child: const Text('Đặt lại tất cả bộ lọc'),
            ),
          ],
        ),
      );
    }

    // Step 8: LayoutBuilder để quyết định layout theo maxWidth
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          // Màn hình điện thoại (< 800px): Sử dụng ListView.builder 1 cột
          return ListView.builder(
            itemCount: movies.length,
            padding: const EdgeInsets.symmetric(vertical: 2),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
                isGridView: false,
                isCompactHeight: isCompactHeight,
                onTap: () => _showMovieDetails(movies[index]),
              );
            },
          );
        } else {
          // Màn hình Tablet / Web (>= 800px): Sử dụng GridView 2 cột
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 10,
              childAspectRatio: isCompactHeight ? 3.0 : 2.7,
            ),
            itemCount: movies.length,
            padding: const EdgeInsets.symmetric(vertical: 2),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: movies[index],
                isGridView: true,
                isCompactHeight: isCompactHeight,
                onTap: () => _showMovieDetails(movies[index]),
              );
            },
          );
        }
      },
    );
  }
}

// ----------------------------------------------------------------------------
// Widget: Movie Card (Tích hợp LayoutBuilder để thích ứng kích thước poster)
// ----------------------------------------------------------------------------

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isGridView;
  final bool isCompactHeight;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    required this.isGridView,
    required this.isCompactHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.symmetric(vertical: isGridView ? 0 : 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Tính toán kích thước poster linh hoạt
            final posterWidth = constraints.maxWidth < 350 ? 70.0 : 85.0;
            final posterHeight = isCompactHeight ? 85.0 : 100.0;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  // Poster hình ảnh
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: posterWidth,
                      height: posterHeight,
                      child: Image.network(
                        movie.posterUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.blueGrey[100],
                            child: const Center(
                              child: Icon(
                                Icons.movie_outlined,
                                size: 28,
                                color: Colors.blueGrey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Thông tin chi tiết phim
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${movie.year}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.star_rounded,
                              size: 15,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              '${movie.rating}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie.genresText,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Nút xem chi tiết
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
