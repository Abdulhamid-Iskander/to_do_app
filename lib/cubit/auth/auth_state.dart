class AuthState {
  final String name;
  final String email;
  final String language;
  final int themeColor;

  AuthState({
    this.name = 'User Name', 
    this.email = 'Email',
    this.language = 'English',
    this.themeColor = 0xFFE91E63,
  });

  AuthState copyWith({
    String? name,
    String? email,
    String? language,
    int? themeColor,
  }) {
    return AuthState(
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
      themeColor: themeColor ?? this.themeColor,
    );
  }
}