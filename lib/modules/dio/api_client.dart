import 'package:dio/dio.dart';

class ApiClient {
  late Dio dio;
  ApiClient() {
    dio = Dio();
    dio.options.baseUrl = 'http://192.168.0.159:5555';
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
  }

  Future<void> autenticar(String email, String senha) async {
    Response response;
    response =
        await dio.post('/autenticar', data: {'email': email, 'senha': senha});
    print(response.data.toString());
  }
}
