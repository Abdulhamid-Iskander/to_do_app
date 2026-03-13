class AuthState {
  final String name;
  final String email;
  final String language;

  AuthState({
    this.name = 'User Name', 
    this.email = 'user@example.com',
    this.language = 'English',
  });

  AuthState copyWith({
    String? name,
    String? email,
    String? language,
  }) {
    return AuthState(
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
    );
  }
}