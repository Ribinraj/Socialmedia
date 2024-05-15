
class CommentModel {
  final String id;
  final CommentUser user;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.user,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      user: CommentUser.fromJson(json['userId']),
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class CommentUser {
  final String id;
  final String userName;
  final String profilePic;

  CommentUser({
    required this.id,
    required this.userName,
    required this.profilePic,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['_id'],
      userName: json['userName'],
      profilePic: json['profilePic'],
    );
  }
}