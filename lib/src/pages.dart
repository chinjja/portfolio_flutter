import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:portfolio/src/widgets.dart';

class MyMarkdownPage extends StatelessWidget {
  const MyMarkdownPage({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path.substring(path.lastIndexOf('/') + 1)),
      ),
      body: FutureBuilder<String>(
          future: rootBundle.loadString(path),
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Markdown(data: data);
          }),
    );
  }

  static Future<T?> push<T>(BuildContext context, String path) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => MyMarkdownPage(
          path: path,
        ),
      ),
    );
  }
}

class FullScreenPage extends StatelessWidget {
  const FullScreenPage({
    Key? key,
    required this.images,
    this.initialIndex = 0,
  }) : super(key: key);
  final List<String> images;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyImagePagenation(
        images: images,
        enableTap: false,
        initialIndex: initialIndex,
      ),
    );
  }
}
