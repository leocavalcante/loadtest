import 'dart:io';
import 'dart:isolate';

_serve(_) async {
  final data = await new File('mockdata.json').readAsBytes();
  final server = await HttpServer.bind('0.0.0.0', 8080, shared: true);

  await for (final request in server) {
    request.response
      ..add(data)
      ..close();
  }
}

main(List<String> args) async {
  final port = new ReceivePort();

  port.listen((e) {
    print('Isolate error: $e');
  });

  for (int i = 0; i < Platform.numberOfProcessors; i++) {
    Isolate.spawn(_serve, null, onError: port.sendPort);
  }
}
