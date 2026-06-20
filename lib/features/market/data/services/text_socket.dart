abstract class TextSocket {
  Stream<String> get messages;
  void send(String message);
  Future<void> close();
}
