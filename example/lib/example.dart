import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';

main() async {
  final dio = Dio(BaseOptions(
    headers: {
      'accept-encoding': 'br',
    },
  ));

  dio.transformer = DioBrotliTransformer();

  Response response = await dio.get('https://google.com');
  print(response.data);
}
