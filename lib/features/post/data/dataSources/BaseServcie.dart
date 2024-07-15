import 'package:dio/dio.dart';

class BaseServcie {
  final Dio dio;
  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  late Response response;

  BaseServcie({required this.dio});
}

class PostServcie extends BaseServcie {
  PostServcie({required super.dio});
  Future<Response> getPosts() async {
    response = await dio.get(baseUrl);
    return response;
  }
}
