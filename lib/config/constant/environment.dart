import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String API_URL = dotenv.env['API_URL'] ?? 'http://18.204.251.12:8081/api/sarti';
  static String API_VERSION = dotenv.env['API_VERSION'] ?? 'v1';
}