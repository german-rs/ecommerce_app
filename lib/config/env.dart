import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get homeUrl => dotenv.env['FIREBASE_HOME_URL'] ?? '';
  static String get cartUrl => dotenv.env['FIREBASE_CART_URL'] ?? '';
}
