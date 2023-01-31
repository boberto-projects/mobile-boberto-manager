class AppConfig {
  ///Configuração API
  static const String apiKey = String.fromEnvironment('API_KEY');
  static const String apiKeyHeader = String.fromEnvironment("API_HEADER");
  static const String apiUrl = String.fromEnvironment("API_URL");

  ///Configuração usuário
  static String authenticationJWTBaerer = "USER_TOKEN";

  ///Codigo OTP
  static const String otpKey = String.fromEnvironment("OTP_KEY");
  static int otpInterval = 60;
  static int otpLength = 6;
}
