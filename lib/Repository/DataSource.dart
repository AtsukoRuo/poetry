class DataSource {
  DataSource._();

  Future<void> connect(ConnectionArgument? connectionArgument) async {
    throw UnimplementedError();
  }

  Future<void> close() async {
    throw UnimplementedError();
  }
}

class ConnectionArgument {}
