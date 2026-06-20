import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_tracker/features/market/data/services/alpaca_price_stream.dart';
import 'package:portfolio_tracker/features/market/data/services/text_socket.dart';
import 'package:portfolio_tracker/features/market/domain/entities/live_tick.dart';
import 'package:portfolio_tracker/features/market/domain/entities/market_data_exception.dart';

class FakeTextSocket implements TextSocket {
  final _incoming = StreamController<String>();
  final List<String> sent = [];
  bool closed = false;

  void emit(String frame) => _incoming.add(frame);

  @override
  Stream<String> get messages => _incoming.stream;

  @override
  void send(String message) => sent.add(message);

  @override
  Future<void> close() async {
    closed = true;
    await _incoming.close();
  }
}

void main() {
  test('handshake: sends auth, then subscribe after authenticated', () async {
    final fake = FakeTextSocket();
    final source = AlpacaPriceStream(
      openSocket: () => fake,
      key: 'k',
      secret: 's',
    );

    final sub = source.watchTrades(['BTC/USD']).listen((_) {});
    await Future<void>.delayed(Duration.zero);

    expect(fake.sent.first, contains('"action":"auth"'));

    fake.emit('[{"T":"success","msg":"authenticated"}]');
    await Future<void>.delayed(Duration.zero);

    expect(fake.sent.any((m) => m.contains('"action":"subscribe"')), isTrue);
    await sub.cancel();
  });

  test('a trade frame becomes a LiveTick on the stream', () async {
    final fake = FakeTextSocket();
    final source = AlpacaPriceStream(
      openSocket: () => fake,
      key: 'k',
      secret: 's',
    );

    final ticks = <LiveTick>[];
    final sub = source.watchTrades(['BTC/USD']).listen(ticks.add);
    await Future<void>.delayed(Duration.zero);

    fake.emit('[{"T":"t","S":"BTC/USD","p":67000.0,"s":0.01}]');
    await Future<void>.delayed(Duration.zero);

    expect(ticks, hasLength(1));
    expect(ticks.first.price, 67000.0);
    await sub.cancel();
  });

  test('an error frame surfaces as a typed error on the stream', () async {
    final fake = FakeTextSocket();
    final source = AlpacaPriceStream(
      openSocket: () => fake,
      key: 'bad',
      secret: 'bad',
    );

    final errors = <Object>[];
    final sub = source
        .watchTrades(['BTC/USD'])
        .listen((_) {}, onError: errors.add);
    await Future<void>.delayed(Duration.zero);

    fake.emit('[{"T":"error","code":402,"msg":"auth failed"}]');
    await Future<void>.delayed(Duration.zero);

    expect(errors.single, isA<LiveStreamException>());
    await sub.cancel();
  });

  test('cancelling the subscription closes the socket (no leak)', () async {
    final fake = FakeTextSocket();
    final source = AlpacaPriceStream(
      openSocket: () => fake,
      key: 'k',
      secret: 's',
    );

    final sub = source.watchTrades(['BTC/USD']).listen((_) {});
    await Future<void>.delayed(Duration.zero);

    await sub.cancel();
    expect(fake.closed, isTrue);
  });
}
