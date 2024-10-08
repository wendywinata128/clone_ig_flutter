class Post {
  Post({
    required this.likes,
    required this.photoUrl,
    required this.description,
    required this.id,
    required this.comments,
    required this.createddt,
    this.avatar,
  });

  late int likes;
  late final int userLikes;
  late final String photoUrl;
  late final String description;
  late final int id;
  late final int comments;
  late final String createddt;
  late final String username;
  late final String? avatar;

  Post.fromJson(Map<String, dynamic> json) {
    likes = json['likes'];
    userLikes = json['userLikes'] ?? 0;
    photoUrl = json['photoUrl'];
    description = json['description'];
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    comments = json['comments'];
    createddt = json['createddt'];
  }
}
