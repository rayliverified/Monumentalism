import 'dart:convert';

import 'package:codelessly_sdk/codelessly_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configBytes = await rootBundle.load('assets/codelessly_config.json');
  final configString = utf8.decode(configBytes.buffer.asUint8List());
  final configMap = jsonDecode(configString);

  final authToken = configMap['authToken'];
  final slug = configMap['slug'];
  final layoutID = configMap['layoutID'];

  final String? effectiveSlug =
      slug is String && slug.trim().isNotEmpty ? slug : null;
  final String? effectiveLayoutID =
      layoutID is String && layoutID.trim().isNotEmpty ? layoutID : null;

  Codelessly.instance.initialize(
    config: CodelesslyConfig(
      authToken: authToken,
      slug: effectiveSlug,
    ),
  );

  runApp(
    MaterialApp(
      home: CodelesslyWidget(
        layoutID: effectiveLayoutID,
      ),
    ),
  );
}
