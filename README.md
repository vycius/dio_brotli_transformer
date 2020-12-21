# Dio Brotli transformer

Brotli response support for Dio http client

## Get started

### Add dependency

```yaml
dependencies:
  dio_brotli_transformer: 0.1.0
```

### Super simple to use

```dart
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  headers: {
    'accept-encoding': 'br',
  },
 ));

dio.transformer = DioBrotliTransformer();
```

