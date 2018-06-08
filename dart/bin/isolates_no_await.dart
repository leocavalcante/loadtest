import 'dart:async';
import 'dart:io';
import 'dart:isolate';

Future _serve(_) async {
  final payloadFile = new File('mockdata.json');
  final payload = await payloadFile.readAsString();

  final server =
      await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);

  await for (final request in server) {
    request.response
      ..write(payload)
      ..close();
  }
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
