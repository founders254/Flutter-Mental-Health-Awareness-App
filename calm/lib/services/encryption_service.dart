import 'package:encrypt/encrypt.dart';
final key = Key.fromUtf8('32charlongencryptionkey');
final iv = IV.fromLength(16);
final encrypter = Encrypter(AES(key));

String encryptMessage(String message) {
  return encrypter.encrypt(message, iv: iv).base64;
}

String decryptMessage(String encryptedMessage) {
  return encrypter.decrypt64(encryptedMessage, iv: iv);
}
