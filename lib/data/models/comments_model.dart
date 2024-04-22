// class CommentModel {
//     List<Comment> comments;
//     String message;
//     int status;

//     CommentModel({
//         required this.comments,
//         required this.message,
//         required this.status,
//     });

//     factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
//         comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
//         message: json["message"],
//         status: json["status"],
//     );

//     Map<String, dynamic> toJson() => {
//         "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
//         "message": message,
//         "status": status,
//     };
// }

// class Comment {
//     String id;
//     UserId userId;
//     String postId;
//     String userName;
//     String content;
//     bool deleted;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;
//     int repliesCount;

//     Comment({
//         required this.id,
//         required this.userId,
//         required this.postId,
//         required this.userName,
//         required this.content,
//         required this.deleted,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.repliesCount,
//     });

//     factory Comment.fromJson(Map<String, dynamic> json) => Comment(
//         id: json["_id"],
//         userId: UserId.fromJson(json["userId"]),
//         postId: json["postId"],
//         userName: json["userName"],
//         content: json["content"],
//         deleted: json["deleted"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         repliesCount: json["repliesCount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId.toJson(),
//         "postId": postId,
//         "userName": userName,
//         "content": content,
//         "deleted": deleted,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "repliesCount": repliesCount,
//     };
// }

// class UserId {
//     String id;
//     String userName;
//     String email;
//     String password;
//     String profilePic;
//     String phone;
//     bool online;
//     bool blocked;
//     bool verified;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;
//     String role;
//     String bio;
//     String name;
//     bool isPrivate;
//     String backGroundImage;

//     UserId({
//         required this.id,
//         required this.userName,
//         required this.email,
//         required this.password,
//         required this.profilePic,
//         required this.phone,
//         required this.online,
//         required this.blocked,
//         required this.verified,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.role,
//         required this.bio,
//         required this.name,
//         required this.isPrivate,
//         required this.backGroundImage,
//     });

//     factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//         id: json["_id"],
//         userName: json["userName"],
//         email: json["email"],
//         password: json["password"],
//         profilePic: json["profilePic"],
//         phone: json["phone"],
//         online: json["online"],
//         blocked: json["blocked"],
//         verified: json["verified"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         role: json["role"],
//         bio: json["bio"],
//         name: json["name"],
//         isPrivate: json["isPrivate"],
//         backGroundImage: json["backGroundImage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userName": userName,
//         "email": email,
//         "password": password,
//         "profilePic": profilePic,
//         "phone": phone,
//         "online": online,
//         "blocked": blocked,
//         "verified": verified,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "role": role,
//         "bio": bio,
//         "name": name,
//         "isPrivate": isPrivate,
//         "backGroundImage": backGroundImage,
//     };
// }
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