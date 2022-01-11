import 'package:flutter/material.dart';
import 'package:snest/util/format/number.dart';

class ReactionBuilder {
  static Widget buildLikeGroup(List likeGroup, int totalLike) {
    return likeGroup.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                ...likeGroup.map((like) {
                  return buildLikeItem(like);
                }).toList(),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    UtilNumberFormat.formatNumber(totalLike),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
  }

  static Widget buildLikeItem(Map<String, dynamic> like) {
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

  static Widget buildPrivacy(int privacy) {
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
}
