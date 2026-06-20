import 'package:web_socket_channel/web_socket_channel.dart';

import 'text_socket.dart';

class WebSocketTextSocket implements TextSocket {
  final WebSocketChannel _channel;

  WebSocketTextSocket(Uri uri) : _channel = WebSocketChannel.connect(uri);

  @override
  Stream<String> get messages =>
      _channel.stream.map((event) => event as String);

  @override
  void send(String message) => _channel.sink.add(message);

  @override
  Future<void> close() => _channel.sink.close();
}
