abstract final class ApiConfig {
  static const String eodhdBaseUrl = 'https://eodhd.com/api';
  static const String eodhdApiKey = String.fromEnvironment(
    'EODHD_API_KEY',
    defaultValue: 'demo',
  );
}
