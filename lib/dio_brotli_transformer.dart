library dio_brotli_transformer;

import 'dart:typed_data';
import 'package:brotli/brotli.dart';

import 'package:dio/dio.dart';

class DioBrotliTransformer extends Transformer {
  Transformer transformer;

  DioBrotliTransformer({Transformer transformer})
      : this.transformer = transformer ?? DefaultTransformer();

  @override
  Future<String> transformRequest(RequestOptions options) {
    return transformer.transformRequest(options);
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    final contentEncodingHeaders = response.headers["content-encoding"] ?? [];

    final brotliHeader = contentEncodingHeaders.firstWhere(
      (h) => h.toLowerCase() == 'br',
      orElse: () => null,
    );

    if (brotliHeader != null) {
      response.stream = response.stream
          .cast<List<int>>()
          .transform(brotli.decoder)
          .map((b) => Uint8List.fromList(b));
    }

    return transformer.transformResponse(options, response);
  }
}
