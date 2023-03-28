import 'package:dio/dio.dart';

class WebService {
  final Dio _dio = Dio();

  Future<Response> postFormRequest({
    required String url,
    Map<String, dynamic>? header,
    required FormData formData,
  }) async {
    Response response = await _dio.post(
      url,
      data: formData,
      options: Options(
        responseType: ResponseType.plain,
        contentType: 'application/json',
        headers: header,
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );

    return response;
  }
}
