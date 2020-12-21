import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Dio _buildDio() {
    return Dio(
      BaseOptions(headers: {
        "accept-encoding": "br",
      }),
    )..transformer = DioBrotliTransformer();
  }

  test('brotli response should be transformed', () async {
    final dio = _buildDio();
    final r = await dio.get("https://httpbin.org/brotli");

    expect(r.data['brotli'], true);
    expect(r.data['headers']['Accept-Encoding'], 'br');
    expect(r.headers[Headers.contentEncodingHeader], ['br']);
  });

  test("without br content type response shouldn't be transformed", () async {
    final dio = _buildDio();
    final r = await dio.get("https://httpbin.org/json");

    print(r.headers);
    expect(r.data['slideshow']['title'], "Sample Slide Show");
    expect(r.data['headers']['accept-encoding'], 'br');
  });
}
