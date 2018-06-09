import 'dart:async';
import 'dart:io';
import 'dart:isolate';

Future _serve(_) async {
  final data = await new File('mockdata.json').readAsBytes();

  final server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);

  Future _handleRequest(HttpRequest request) async {
    final response = request.response..add(data);
    await response.close();
  }

  server.listen(_handleRequest);
}

Future main(List<String> args) async {
  final port = new ReceivePort();

  port.listen((e) {
    print('Isolate error: $e');
  });

  for (int i = 0; i < Platform.numberOfProcessors; i++) {
    await Isolate.spawn(_serve, null, onError: port.sendPort);
  }
}
