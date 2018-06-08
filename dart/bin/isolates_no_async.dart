import 'dart:io';
import 'dart:isolate';

void _serve(_) {
  final payloadFile = new File('mockdata.json');
  final payload = payloadFile.readAsStringSync();

  HttpServer
      .bind(InternetAddress.loopbackIPv4, 8080, shared: true)
      .then((server) {
    server.listen((request) {
      request.response
        ..write(payload)
        ..close();
    });
  });
}

void main(List<String> args) {
  final port = new ReceivePort();

  port.listen((e) {
    print('Isolate error: $e');
  });

  for (int i = 0; i < Platform.numberOfProcessors; i++) {
    Isolate.spawn(_serve, null, onError: port.sendPort);
  }
}
