class MarketDataException implements Exception {
  final String message;

  MarketDataException(this.message);

  @override
  String toString() => 'MarketDataException: $message';
}

class NetworkException extends MarketDataException {
  NetworkException(super.message);
}

class ApiKeyException extends MarketDataException {
  ApiKeyException(String symbol)
    : super(
        'EODHD rejected the request for $symbol - '
        'check your API key or daily quota',
      );
}

class MarketDataParseException extends MarketDataException {
  MarketDataParseException(super.message);
}

class LiveStreamException extends MarketDataException {
  LiveStreamException(super.message);
}
