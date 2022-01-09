import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key, required this.post}) : super(key: key);
  final Map<String, dynamic> post;
  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    print(widget.post);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Detail'),
      ),
      body: const Center(
        child: Text('Post Detail'),
      ),
    );
  }
}
