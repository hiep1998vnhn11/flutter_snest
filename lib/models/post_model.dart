class PostModel {
  final int id;
  final String content;
  final String imageUrl;
  final String userId;
  final String userName;
  final String userImageUrl;
  final int likes;
  final int comments;
  final int shares;
  final int views;
  final String createdAt;
  final String updatedAt;

  const PostModel({
    required this.id,
    required this.content,
    required this.imageUrl,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      userId: json['userId'],
      userName: json['userName'],
      userImageUrl: json['userImageUrl'],
      likes: json['likes'],
      comments: json['comments'],
      shares: json['shares'],
      views: json['views'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
