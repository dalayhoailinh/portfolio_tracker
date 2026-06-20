abstract final class ApiConfig {
  static const String eodhdBaseUrl = 'https://eodhd.com/api';
  static const String eodhdApiKey = String.fromEnvironment(
    'EODHD_API_KEY',
    defaultValue: 'demo',
  );

  static const String alpacaCryptoWsUrl =
      'wss://stream.data.alpaca.markets/v1beta3/crypto/us';
  static const String alpacaCryptoDataUrl =
      'https://data.alpaca.markets/v1beta3/crypto/us';
  static const String alpacaKey = String.fromEnvironment(
    'ALPACA_KEY',
    defaultValue: '',
  );
  static const String alpacaSecret = String.fromEnvironment(
    'ALPACA_SECRET',
    defaultValue: '',
  );
}
