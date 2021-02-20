import 'package:logger/logger.dart';

var logger = Logger(
  level: Level.info,
  filter: null,
  printer: PrettyPrinter(colors: false, printTime: false, printEmojis: true, lineLength: 110, methodCount: 0),
  output: null,
);
