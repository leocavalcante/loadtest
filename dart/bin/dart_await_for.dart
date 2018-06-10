import 'dart:async';
import 'dart:io';

Future main() async {
  final server = await HttpServer.bind('0.0.0.0', 8080);

  await for (final request in server) {
    final data = await new File('mockdata.json').readAsBytes();

    request.response
      ..add(data)
      ..close();
  }
}
