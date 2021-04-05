import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';

Future<void> main() async {
  final dio = Dio(BaseOptions(
    headers: {
      'accept-encoding': 'br',
    },
  ));

  dio.transformer = DioBrotliTransformer();

  final response = await dio.get('https://httpbin.org/brotli');
  print(response.data);
}
