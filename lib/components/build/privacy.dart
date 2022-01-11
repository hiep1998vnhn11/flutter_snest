import 'package:flutter/material.dart';

Widget _buildPrivacy(int privacy) {
  if (privacy == 1) {
    return const Icon(
      Icons.public,
      size: 16,
      color: Colors.grey,
    );
  } else if (privacy == 2) {
    return const Icon(
      Icons.supervised_user_circle,
      size: 15,
      color: Colors.grey,
    );
  } else if (privacy == 3) {
    return const Icon(
      Icons.lock_outline,
      size: 15,
      color: Colors.grey,
    );
  } else {
    return const Icon(
      Icons.public,
      size: 15,
      color: Colors.grey,
    );
  }
}
