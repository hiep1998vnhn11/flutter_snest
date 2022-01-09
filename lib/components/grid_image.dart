import 'package:flutter/material.dart';

class GridImage extends StatelessWidget {
  final Set<String> images;
  GridImage({this.images = []});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 200,
            width: 200,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            price,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
