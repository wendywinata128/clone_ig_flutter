class Story {
  late final String username;
  late final String name;
  late final String? avatar;

  Story({
    required this.username,
    required this.name,
    this.avatar,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      name: json['name'],
      username: json['username'],
      avatar: json['avatar'],
    );
  }
}
