import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

bool compareHash(String input, String hashedValue) {
  return hashString(input) == hashedValue;
}
