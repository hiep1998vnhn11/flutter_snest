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
  value: '0',
  icon: _buildReactionsIcon(
    'images/reactions/no-react.png',
    const Text(
      'Thích',
    ),
  ),
);

final reactions = [
  Reaction<String>(
    value: '1',
    title: _buildTitle('Thích'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/like.png'),
    icon: _buildReactionsIcon(
      'images/reactions/like.png',
      const Text(
        'Thích',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '2',
    title: _buildTitle('Yêu thích'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/love.png'),
    icon: _buildReactionsIcon(
      'images/reactions/love.png',
      const Text(
        'Yêu thích',
        style: TextStyle(
          color: Color(0XFFed5168),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '3',
    title: _buildTitle('Thương thương'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/care.png'),
    icon: _buildReactionsIcon(
      'images/reactions/care.png',
      const Text(
        'Thương thương',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '4',
    title: _buildTitle('Haha'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/haha.png'),
    icon: _buildReactionsIcon(
      'images/reactions/haha.png',
      const Text(
        'Haha',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '5',
    title: _buildTitle('Wow'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/wow.png'),
    icon: _buildReactionsIcon(
      'images/reactions/wow.png',
      const Text(
        'Wow',
        style: TextStyle(
          color: Color(0XFFffda6b),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '6',
    title: _buildTitle('Buồn'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/sad.png'),
    icon: _buildReactionsIcon(
      'images/reactions/sad.png',
      const Text(
        'Buồn',
        style: TextStyle(
          color: Color(0XFFf05766),
        ),
      ),
    ),
  ),
  Reaction<String>(
    value: '7',
    title: _buildTitle('Giận dữ'),
    previewIcon: _buildReactionsPreviewIcon('images/reactions/angry.png'),
    icon: _buildReactionsIcon(
      'images/reactions/angry.png',
      const Text(
        'Giận dữ',
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

class PostBuilder {
  static Widget _buildLikeItem(Map<String, dynamic> like) {
    if (like['status'] == 1) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/like.png'),
        radius: 9,
      );
    }
    if (like['status'] == 2) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/love.png'),
        radius: 9,
      );
    }
    if (like['status'] == 3) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/care.png'),
        radius: 9,
      );
    }
    if (like['status'] == 4) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/haha.png'),
        radius: 9,
      );
    }
    if (like['status'] == 5) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/wow.png'),
        radius: 9,
      );
    }
    if (like['status'] == 6) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/sad.png'),
        radius: 9,
      );
    }
    if (like['status'] == 7) {
      return const CircleAvatar(
        backgroundImage: AssetImage('images/reactions/angry.png'),
        radius: 9,
      );
    }
    return const CircleAvatar(
      backgroundImage: AssetImage('images/reactions/like.png'),
      radius: 9,
    );
  }
}
