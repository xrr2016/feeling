List<String> movieTypes = [
  'popular',
  'upcoming',
  'top_rated',
  'now_playing',
];

enum MovieTpye {
  POPULAR,
  UPCOMING,
  TOP_RATED,
  NOW_PLAYING,
}

extension MovieTpyeExtension on MovieTpye {
  String get name {
    switch (this) {
      case MovieTpye.POPULAR:
        return 'popular';
      case MovieTpye.UPCOMING:
        return 'upcoming';
      case MovieTpye.TOP_RATED:
        return 'top_rated';
      case MovieTpye.NOW_PLAYING:
        return 'now_playing';
      default:
        return 'upcoming';
    }
  }
}
