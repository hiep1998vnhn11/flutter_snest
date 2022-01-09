import 'package:flutter/material.dart';

class GridImage extends StatelessWidget {
  final List<String> images;
  const GridImage({Key? key, this.images = const []}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: _buildListImage());
  }

  List<Widget> _buildListImage() {
    return images
        .map(
          (image) => Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
  }
}
