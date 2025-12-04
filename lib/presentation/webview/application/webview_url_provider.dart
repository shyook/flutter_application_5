import 'package:flutter_riverpod/flutter_riverpod.dart';

final webViewUrlProvider = Provider<String>((ref) {
  return "about:blank"; // 기본 URL 실제는 Controller가 override
});