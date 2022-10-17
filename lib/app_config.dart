class AppConfig {
  ///Configuração API
  static const String apiKey =
      String.fromEnvironment('API_KEY', defaultValue: "");
  static const String apiKeyHeader =
      String.fromEnvironment("API_HEADER", defaultValue: "");
  static const String apiUrl =
      String.fromEnvironment("API_URL", defaultValue: "");

  ///Configuração usuário
  static String autenticacaoJWTChave = "USER_TOKEN";

  ///Codigo OTP
  static const String otpKey =
      String.fromEnvironment("OTP_KEY", defaultValue: "");
  static int otpIntervalo = 60;
  static int otpTamanho = 6;
}
