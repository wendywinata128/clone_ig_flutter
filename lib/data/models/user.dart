class User {
  String? createddt;
  late final String updateddt;
  late final int id;
  late final String email;
  late final String username;
  late final String name;
  late final String? avatar;
  late final int followers;
  late final int following;
  late final int posts;
  late bool isFollow;

  User({
    required this.id,
    required this.createddt,
    required this.updateddt,
    required this.email,
    required this.username,
    required this.name,
    this.followers = 0,
    this.following = 0,
    this.posts = 0,
    this.isFollow = false,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createddt: json['createddt'],
      updateddt: json['updateddt'],
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: json['name'],
      avatar: json['avatar'],
      posts: json['posts'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      isFollow: (json['isFollow'] ?? 0) > 0 ? true : false,
    );
  }
}
