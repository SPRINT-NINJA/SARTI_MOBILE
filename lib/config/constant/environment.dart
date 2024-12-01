import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String API_URL = dotenv.env['API_URL'] ?? 'http://localhost:3000';
  static String API_VERSION = dotenv.env['API_VERSION'] ?? 'v1';
}