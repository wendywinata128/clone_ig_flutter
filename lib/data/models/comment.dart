import 'package:clone_ig_flutter/data/models/user.dart';

class Comment {
  Comment({
    required this.description,
    required this.id,
    required this.user,
    required this.createddt,
    this.isNew = false,
  });

  late final String description;
  late final int id;
  late final User user;
  late final String createddt;
  late bool isNew;

  Comment.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    user = User.fromJson(json['user']);
    createddt = json['createddt'];
    isNew = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['id'] = id;
    data['user'] = user;
    data['createddt'] = createddt;
    return data;
  }
}
