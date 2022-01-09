import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

List<Reaction<String>> flagsReactions = [
  Reaction<String>(
    value: 'en',
    previewIcon: _builFlagsdPreviewIcon(
        'images/reactions/united-kingdom-round.png', 'English'),
    icon: _buildIcon('images/reactions/united-kingdom.png'),
  ),
  Reaction<String>(
    value: 'ar',
    previewIcon:
        _builFlagsdPreviewIcon('images/reactions/algeria-round.png', 'Arabic'),
    icon: _buildIcon('images/reactions/algeria.png'),
  ),
  Reaction<String>(
    value: 'gr',
    previewIcon:
        _builFlagsdPreviewIcon('images/reactions/germany-round.png', 'German'),
    icon: _buildIcon('images/reactions/germany.png'),
  ),
  Reaction<String>(
    value: 'sp',
    previewIcon:
        _builFlagsdPreviewIcon('images/reactions/spain-round.png', 'Spanish'),
    icon: _buildIcon('images/reactions/spain.png'),
  ),
  Reaction<String>(
    value: 'ch',
    previewIcon:
        _builFlagsdPreviewIcon('images/reactions/china-round.png', 'Chinese'),
    icon: _buildIcon('images/reactions/china.png'),
  ),
];

final defaultInitialReaction = Reaction<String>(
  value: null,
  icon: _buildReactionsIcon(
    'images/reactions/no-react.png',
    const Text(
      'Thích',
    ),
  ),
);

final reactions = [
  Reaction<String>(
    value: 'Like',
    title: _buildTitle('Thích'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/like.png'),
    icon: _buildReactionsIcon(
      'images/reactions/like.png',
      const Text(
        'Thích',
        style: TextStyle(
          color: Color(0XFF3b5998),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Angry',
    title: _buildTitle('Angry'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/angry.png'),
    icon: _buildReactionsIcon(
      'images/reactions/angry.png',
      const Text(
        'Angry',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'In love',
    title: _buildTitle('In love'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/in-love.png'),
    icon: _buildReactionsIcon(
      'images/reactions/in-love.png',
      const Text(
        'In love',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Sad',
    title: _buildTitle('Sad'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/sad.png'),
    icon: _buildReactionsIcon(
      'images/reactions/sad.png',
      const Text(
        'Sad',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Surprised',
    title: _buildTitle('Surprised'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/surprised.png'),
    icon: _buildReactionsIcon(
      'images/reactions/surprised.png',
      const Text(
        'Surprised',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: 'Mad',
    title: _buildTitle('Mad'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/mad.png'),
    icon: _buildReactionsIcon(
      'images/reactions/mad.png',
      const Text(
        'Mad',
        style: TextStyle(
          color: Color(0XFFf05766),
        ),
      ),
    ),
  ),
];

Padding _builFlagsdPreviewIcon(String path, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7.5),
        Image.asset(path, height: 30),
      ],
    ),
  );
}

Container _buildTitle(String title) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Padding _buildReactionsPreviewIcon(String path) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
    child: Image.asset(path, height: 40),
  );
}

Image _buildIcon(String path) {
  return Image.asset(
    path,
    height: 30,
    width: 30,
  );
}

Container _buildReactionsIcon(String path, Text text) {
  return Container(
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        Image.asset(path, height: 20),
        const SizedBox(width: 5),
        text,
      ],
    ),
  );
}
