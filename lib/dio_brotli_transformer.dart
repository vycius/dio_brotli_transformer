library dio_brotli_transformer;

import 'dart:typed_data';

import 'package:brotli/brotli.dart';
import 'package:dio/dio.dart';

class DioBrotliTransformer extends Transformer {
  Transformer transformer;

  DioBrotliTransformer({Transformer? transformer})
      : transformer = transformer ?? DefaultTransformer();

  @override
  Future<String> transformRequest(RequestOptions options) {
    return transformer.transformRequest(options);
  }

  bool _isBrotliEncoding(ResponseBody response) {
    final contentEncodingHeaders = response.headers['content-encoding'] ?? [];

    if (contentEncodingHeaders.isNotEmpty) {
      return contentEncodingHeaders[0].toLowerCase() == 'br';
    }

    return false;
  }

  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    if (_isBrotliEncoding(response)) {
      response.stream = response.stream
          .cast<List<int>>()
          .transform(brotli.decoder)
          .map((b) => Uint8List.fromList(b));
    }

    return transformer.transformResponse(options, response);
  }
}
