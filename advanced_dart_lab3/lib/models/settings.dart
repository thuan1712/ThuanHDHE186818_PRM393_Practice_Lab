class Settings {
  String theme;
  String language;

  static final Settings _instance = Settings._internal(
    theme: 'Dark Mode',
    language: 'Vietnamese',
  );

  Settings._internal({required this.theme, required this.language});

  factory Settings() {
    return _instance;
  }

  @override
  String toString() => 'Settings(theme: $theme, language: $language)';
}
