import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

main() async {
  final file = new File('mockdata.json');
  final data = await file.readAsBytes();
  final handler = (request) => new Response.ok(data);

  io.serve(handler, '0.0.0.0', 8080);
}
