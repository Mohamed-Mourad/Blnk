import 'dart:io';

import 'package:flutter/material.dart';

class IdViewer extends StatelessWidget {

  final String title;
  final String path;

  const IdViewer({
    super.key,
    required this.title,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Center(
            child: Image.file(
              File(path),
              fit: BoxFit.contain,
            ),
          ),
        )
    );
  }
}
