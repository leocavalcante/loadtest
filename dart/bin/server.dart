import 'dart:async';
import 'dart:io';

Future main() async {
  final server = await HttpServer.bind('0.0.0.0', 8080);

  await for (final request in server) {
    final file = new File('mockdata.json');
    final data = await file.readAsString();

    final response = request.response..write(data);
    await response.close();
  }
}
