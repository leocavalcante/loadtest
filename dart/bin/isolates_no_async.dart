import 'dart:io';
import 'dart:isolate';

void _serve(_) {
  final data = new File('mockdata.json').readAsBytesSync();

  HttpServer
      .bind(InternetAddress.loopbackIPv4, 8080, shared: true)
      .then((server) {
    server.listen((request) {
      request.response
        ..add(data)
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
