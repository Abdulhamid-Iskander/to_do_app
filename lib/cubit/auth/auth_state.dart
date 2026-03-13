class AuthState {
  final String name;
  final String email;
  final String language;
  final int themeColor;
  final bool isDarkMode;
  final bool isLoading;
  final String? authError;
  final bool isSuccess;

  AuthState({
    this.name = 'User Name', 
    this.email = 'Email',
    this.language = 'English',
    this.themeColor = 0xFFE91E63,
    this.isDarkMode = false,
    this.isLoading = false,
    this.authError,
    this.isSuccess = false,
  });

  AuthState copyWith({
    String? name,
    String? email,
    String? language,
    int? themeColor,
    bool? isDarkMode,
    bool? isLoading,
    String? authError,
    bool? isSuccess,
  }) {
    return AuthState(
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
      themeColor: themeColor ?? this.themeColor,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
      authError: authError,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}