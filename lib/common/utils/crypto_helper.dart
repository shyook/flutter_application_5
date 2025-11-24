import 'dart:convert';
import 'package:pointycastle/export.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';

class CryptHelper {
  static List<int> hexToByteArray(String strData) {
    final data = hexToData(strData);
    if (data == null) {
      return [];
    }
    return data;
  }

  static List<int> padding16(String text) {
    List<int> dataArray = [];
    dataArray.addAll(utf8.encode(text));
    if (dataArray.isEmpty || dataArray.length % 16 != 0) {
      int padLength = 16 - dataArray.length % 16;
      dataArray.addAll(List.filled(padLength, 0x20));
    }
    return dataArray;
  }

  static String encryptByAes(String key, String text) {
    if (text.isEmpty) return "";
    try {
      final urlEncode = urlEncoded(text);
      final key16 = key.substring(16);
      final keyBytes = utf8.encode(key16);
      final dataArray = padding16(urlEncode);

      final cipher = ECBBlockCipher(AESFastEngine())
        ..init(true, KeyParameter(Uint8List.fromList(keyBytes)));

      final encrypted = <int>[];
      for (var offset = 0; offset < dataArray.length; offset += 16) {
        encrypted.addAll(cipher.process(Uint8List.fromList(dataArray.sublist(offset, offset + 16))));
      }

      return hex.encode(encrypted);
    } catch (e) {
      return "";
    }
  }

  static String decryptByAes(String key, String text) {
    if (text.isEmpty) return text;
    if (key.isEmpty) return text;

    try {
      final key16 = key.substring(16);
      final keyBytes = utf8.encode(key16);
      final dataArray = hexToByteArray(text);
      if (dataArray.isEmpty) return "";

      final cipher = ECBBlockCipher(AESFastEngine())
        ..init(false, KeyParameter(Uint8List.fromList(keyBytes)));

      final decrypted = <int>[];
      for (var offset = 0; offset < dataArray.length; offset += 16) {
        decrypted.addAll(cipher.process(Uint8List.fromList(dataArray.sublist(offset, offset + 16))));
      }

      final decString = utf8.decode(decrypted, allowMalformed: true);
      final urlDecode = urlDecoded(decString);

      return urlDecode;
    } catch (e) {
      return "";
    }
  }

  static List<int>? hexToData(String strData) {
    try {
      final cleanStr = strData.replaceAll(RegExp(r'[^0-9a-fA-F]'), '');
      if (cleanStr.length % 2 != 0) return null;
      final bytes = <int>[];
      for (var i = 0; i < cleanStr.length; i += 2) {
        final byteString = cleanStr.substring(i, i + 2);
        final byte = int.parse(byteString, radix: 16);
        bytes.add(byte);
      }
      if (bytes.isEmpty) return null;
      return bytes;
    } catch (_) {
      return null;
    }
  }

  static String urlEncoded(String value) {
    final encoded = Uri.encodeComponent(value);
    return encoded.replaceAll('+', '%2B');
  }

  static String urlDecoded(String value) {
    return Uri.decodeComponent(value);
  }

  static final String privTag = 'your.bundle.identifier'; // Replace with actual bundle identifier

  // Placeholder for SecureEnclaveAccess, as Dart/Flutter does not have direct equivalent
  static final SecureEnclaveAccess = null;

  static final Map<String, dynamic> EnclaveAttribute = {
    'kSecAttrKeyType': 'kSecAttrKeyTypeECSECPrimeRandom',
    'kSecAttrKeySizeInBits': 256,
    'kSecAttrTokenID': 'kSecAttrTokenIDSecureEnclave',
    'kSecPrivateKeyAttrs': {
      'kSecAttrIsPermanent': true,
      'kSecAttrApplicationTag': privTag,
      'kSecAttrAccessControl': SecureEnclaveAccess,
    },
  };

  static final Map<String, dynamic> NonEnclaveAttribute = {
    'kSecAttrKeyType': 'kSecAttrKeyTypeECSECPrimeRandom',
    'kSecAttrKeySizeInBits': 256,
    'kSecPrivateKeyAttrs': {
      'kSecAttrIsPermanent': true,
      'kSecAttrApplicationTag': privTag,
    },
  };

  // The following methods are placeholders since Dart/Flutter does not have direct access to iOS Keychain APIs.
  // You would need to use platform channels or packages like 'flutter_secure_storage' or write native code.

  static Future<dynamic> getPubKey() async {
    Map<String, dynamic> query = {
      'kSecClass': 'kSecClassKey',
      'kSecAttrKeyType': 'kSecAttrKeyTypeECSECPrimeRandom',
      'kSecAttrApplicationTag': privTag,
      'kSecAttrKeyClass': 'kSecAttrKeyClassPrivate',
      'kSecReturnRef': true,
    };

    dynamic result;
    int status = await _secItemCopyMatching(query, (res) => result = res);

    if (status != 0) { // errSecSuccess assumed as 0
      debugPrint("priv key get failed.. generate new key");
      await generateKey();
      status = await _secItemCopyMatching(query, (res) => result = res);
    }
    // result is expected to be a private key reference
    var privKey = result;
    var pubKey = _secKeyCopyPublicKey(privKey);
    return pubKey;
  }

  static Future<dynamic> getPrivKey() async {
    Map<String, dynamic> query = {
      'kSecClass': 'kSecClassKey',
      'kSecAttrKeyType': 'kSecAttrKeyTypeECSECPrimeRandom',
      'kSecAttrApplicationTag': privTag,
      'kSecAttrKeyClass': 'kSecAttrKeyClassPrivate',
      'kSecReturnRef': true,
    };

    dynamic result;
    int status = await _secItemCopyMatching(query, (res) => result = res);
    if (status != 0) {
      debugPrint("priv key get failed.. generate new key");
      await _secItemDelete(query);
      await generateKey();
      status = await _secItemCopyMatching(query, (res) => result = res);
      debugPrint(status.toString());
    }
    var privKey = result;
    return privKey;
  }

  static Future<void> deleteKey() async {
    Map<String, dynamic> Privquery = {
      'kSecClass': 'kSecClassKey',
      'kSecAttrKeyType': 'kSecAttrKeyTypeECSECPrimeRandom',
      'kSecAttrApplicationTag': privTag,
      'kSecAttrKeyClass': 'kSecAttrKeyClassPrivate',
      'kSecReturnRef': true,
    };
    int code = await _secItemDelete(Privquery);
    if (code == 0) {
      debugPrint("Key Delete Complete!");
    } else {
      debugPrint("Delete Failed!!");
      debugPrint(code.toString());
    }
  }

  static Future<void> generateKeyNoEnclave() async {
    // Placeholder: generate a random key without Secure Enclave
    await _secKeyCreateRandomKey(NonEnclaveAttribute);
  }

  static Future<void> generateKey() async {
    var privKey = await _secKeyCreateRandomKey(EnclaveAttribute);
    if (privKey == null) {
      debugPrint("Secure Enclave Not Supported.");
      privKey = await _secKeyCreateRandomKey(NonEnclaveAttribute);
    }
  }

  static Future<String?> encrypt(String input) async {
    final pubKey = await getPubKey();
    if (pubKey == null) {
      return null;
    }

    try {
      final plain = utf8.encode(input);
      final encData = await secKeyCreateEncryptedData(
          pubKey, plain, SecKeyAlgorithm.eciesEncryptionStandardX963SHA256AESGCM);
      if (encData == null) {
        return null;
      }
      final b64result = base64Encode(encData);
      return b64result;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> decrypt(String input) async {
    final privKey = await getPrivKey();

    final encData = base64Decode(input);
    if (encData.isEmpty) {
      return null;
    }

    try {
      final decData = await secKeyCreateDecryptedData(
          privKey, encData, SecKeyAlgorithm.eciesEncryptionStandardX963SHA256AESGCM);
      if (decData == null) {
        return null;
      }
      final decResult = utf8.decode(decData);
      return decResult;
    } catch (e) {
      return null;
    }
  }

  // Placeholder native method stubs

  static Future<int> _secItemCopyMatching(
      Map<String, dynamic> query, Function(dynamic) onResult) async {
    // Implement platform channel call to iOS SecItemCopyMatching
    return 0; // errSecSuccess
  }

  static Future<int> _secItemDelete(Map<String, dynamic> query) async {
    // Implement platform channel call to iOS SecItemDelete
    return 0; // errSecSuccess
  }

  static Future<dynamic> _secKeyCreateRandomKey(Map<String, dynamic> attributes) async {
    // Implement platform channel call to iOS SecKeyCreateRandomKey
    return null;
  }

  static dynamic _secKeyCopyPublicKey(dynamic privKey) {
    // Implement platform channel call to iOS SecKeyCopyPublicKey
    return null;
  }
}

// Placeholder enums and functions to simulate Swift SecKey APIs
  enum SecKeyAlgorithm {
    eciesEncryptionStandardX963SHA256AESGCM,
  }

  Future<dynamic> getPubKey() async {
    // Implement key retrieval logic
    return null;
  }

  Future<dynamic> getPrivKey() async {
    // Implement key retrieval logic
    return null;
  }

  Future<Uint8List?> secKeyCreateEncryptedData(
      dynamic key, List<int> data, SecKeyAlgorithm algorithm) async {
    // Implement encryption logic
    return null;
  }

  Future<Uint8List?> secKeyCreateDecryptedData(
      dynamic key, Uint8List data, SecKeyAlgorithm algorithm) async {
    // Implement decryption logic
    return null;
  }