import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;

String getSalt([int longitud = 16]) {
  final rng = Random.secure();
  final valores = List<int>.generate(longitud, (i) => rng.nextInt(256));
  return base64Url.encode(valores);
}

String cryptoPass(String contrasena, String salt, {int iteraciones = 2}) {
  var contrasenaSalt = utf8.encode(contrasena);
  var hash = sha256.convert(contrasenaSalt);

  for (int i = 0; i < iteraciones; i++) {
    hash = sha256.convert(hash.bytes);
  }

  return hash.toString();
}
