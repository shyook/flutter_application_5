import 'package:dio/dio.dart';
import 'package:flutter_application_5/common/provider/secure_storage_provider.dart';
import 'package:flutter_application_5/common/provider/token_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: dotenv.get("DEV_URL"),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    responseType: ResponseType.json,
  ));

  // 인터셉터 추가
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

  final storage = ref.read(secureStorageProvider);
  storage.read(key: 'token').then((token) {
    dio.interceptors.add(TokenInterceptor(token));
  });

  return dio;
});

final baseWebUrl = dotenv.get("DEV_URL_WEB");

final webBaseUrl = <String, String>{
  "JOIN_MEMBER": "$baseWebUrl/U001/03_02_03.do",
  "B01": "https://url-B.com",
  "C01": "https://url-C.com",
  "DEFAULT": "https://fallback-url.com",
};


// // GET 요청
// Future<void> getRequest() async {
//   try {
//     final response = await dio.get('https://api.example.com/data');
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }

// // POST 요청
// Future<void> postRequest() async {
//   try {
//     final response = await dio.post(
//       'https://api.example.com/create',
//       data: {'name': '홍길동', 'email': 'hong@example.com'},
//     );
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }

// // PUT 요청
// Future<void> putRequest() async {
//   try {
//     final response = await dio.put(
//       'https://api.example.com/update/1',
//       data: {'name': '김철수', 'email': 'kim@example.com'},
//     );
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }

// // DELETE 요청
// Future<void> deleteRequest() async {
//   try {
//     final response = await dio.delete('https://api.example.com/delete/1');
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }

// Future<void> getWithQueryParams() async {
//   try {
//     final response = await dio.get(
//       'https://api.example.com/search',
//       queryParameters: {
//         'keyword': '플러터',
//         'page': 1,
//         'limit': 20,
//       },
//     );
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }


// Future<void> requestWithHeaders() async {
//   try {
//     final response = await dio.get(
//       'https://api.example.com/secure-data',
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );
//     print('응답 데이터: ${response.data}');
//   } catch (e) {
//     print('에러: $e');
//   }
// }


// Future<void> uploadFile() async {
//   try {
//     final formData = FormData.fromMap({
//       'name': '내 문서',
//       'file': await MultipartFile.fromFile(
//         '/path/to/file.pdf',
//         filename: 'document.pdf',
//       ),
//       // 여러 파일 업로드
//       'images': [
//         await MultipartFile.fromFile('/path/to/image1.jpg'),
//         await MultipartFile.fromFile('/path/to/image2.jpg'),
//       ],
//     });

//     final response = await dio.post(
//       'https://api.example.com/upload',
//       data: formData,
//       onSendProgress: (sent, total) {
//         final progress = (sent / total * 100).toStringAsFixed(2);
//         print('업로드 진행률: $progress%');
//       },
//     );

//     print('업로드 완료: ${response.data}');
//   } catch (e) {
//     print('업로드 에러: $e');
//   }
// }