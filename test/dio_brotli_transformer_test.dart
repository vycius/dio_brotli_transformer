// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Dio buildDio() {
    final dio = Dio(
      BaseOptions(
        headers: {
          'accept-encoding': 'br',
        },
      ),
    );

    dio.transformer = DioBrotliTransformer(
      transformer: BackgroundTransformer(),
    );

    return Dio(
      BaseOptions(
        headers: {
          'accept-encoding': 'br',
        },
      ),
    )..transformer = DioBrotliTransformer();
  }

  test('brotli response should be transformed', () async {
    final dio = buildDio();
    final r = await dio.get('https://httpbin.org/brotli');

    expect(r.data['brotli'], true);
    expect(r.data['headers']['Accept-Encoding'], 'br');
    expect(r.headers[Headers.contentEncodingHeader], ['br']);
  });

  test("without br content type response shouldn't be transformed", () async {
    final dio = buildDio();
    final r = await dio.get('https://httpbin.org/json');

    expect(r.data['slideshow']['title'], 'Sample Slide Show');
    expect(r.headers[Headers.contentEncodingHeader], null);
  });
}
