import 'package:flutter/material.dart';

class TagView extends StatelessWidget {
  final List<String> tags;

  const TagView({super.key, this.tags = const ['Flutter', 'Dart', 'Widgets', 'Mobile', 'Development']});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tag List View Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: tags.map((tag) {
              return Chip(
                label: Text(tag),
                backgroundColor: Colors.blue,
                labelStyle: TextStyle(color: Colors.white),

                // onPressed: () {
                //   // Handle tag click event
                //   print('Tag clicked: $tag');
                //   // You can navigate to a new screen, perform an action, etc.
                // },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}