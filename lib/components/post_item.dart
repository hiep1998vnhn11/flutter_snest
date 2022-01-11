import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snest/store/auth.dart';
import 'package:snest/screens/post/post.dart';
import 'package:snest/components/grid_image.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:snest/components/reaction/data/example_data.dart' as example;
import 'package:snest/components/reaction/reaction_builder.dart';

class PostItem extends StatelessWidget {
  final String? avatar;
  final String name;
  final String time;
  final String? img;
  final String? content;
  final List<String> images;
  final int privacy;
  final int id;
  final String pid;
  final String? likeStatus;
  final List likeGroup;
  final int likeCount;
  final Function(int, String?) onLike;
  final Function() onOptions;
  final Function() onShare;

  final AuthController authController = Get.put(AuthController());

  PostItem(
      {Key? key,
      this.avatar,
      required this.name,
      required this.time,
      this.img,
      this.content,
      this.images = const [],
      required this.id,
      required this.privacy,
      required this.pid,
      required this.onLike,
      this.likeStatus,
      required this.onOptions,
      required this.onShare,
      this.likeGroup = const [],
      this.likeCount = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: avatar != null
                ? CircleAvatar(
                    backgroundImage: NetworkImage(
                      avatar!,
                    ),
                  )
                : const CircleAvatar(
                    backgroundImage: AssetImage('images/avatar.png'),
                  ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                size: 20,
              ),
              onPressed: onOptions,
            ),
            subtitle: Row(children: [
              Text(time),
              const Text(' . '),
              _buildPrivacy(),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Text(content ?? ''),
          ),
          GridImage(
            images: images,
          ),
          ReactionBuilder.buildLikeGroup(likeGroup, likeCount),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: ReactionButtonToggle<String>(
                      onReactionChanged: (String? value, bool isChecked) {
                        onLike(id, value);
                      },
                      reactions: example.reactions,
                      initialReaction: example.defaultInitialReaction,
                      selectedReaction: example.reactions[
                          likeStatus == null || likeStatus == '0'
                              ? 0
                              : int.parse(likeStatus!) - 1],
                      isChecked: likeStatus != null && likeStatus != '0',
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(
                    () => PostScreen(
                      id: id,
                      privacy: privacy,
                      avatar: avatar,
                      name: name,
                      content: content,
                      pid: pid,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.message,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Bình luận',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: onShare,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.share,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Chia sẻ',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildPrivacy() {
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
