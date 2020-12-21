# Dio Brotli transformer
![Test](https://github.com/vycius/dio_brotli_transformer/workflows/Test/badge.svg?branch=main)

Brotli response support for Dio http client

## Get started

### Installation

In `pubspec.yaml` add the following dependency:

```yaml
dependencies:
  dio_brotli_transformer: 0.1.0
```

### Super simple to use

```dart
import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';

final dio = Dio(BaseOptions(
  headers: {
    'accept-encoding': 'br',
  },
 ));

dio.transformer = DioBrotliTransformer();
```

## Examples
### Change default transformer
```dart
import 'package:dio/dio.dart';
import 'package:dio_brotli_transformer/dio_brotli_transformer.dart';

final dio = Dio(BaseOptions(
  headers: {
    'accept-encoding': 'br',
  },
));

dio.transformer = DioBrotliTransformer(transformer: DefaultTransformer());
```
 