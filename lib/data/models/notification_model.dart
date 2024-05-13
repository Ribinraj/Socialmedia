class NotificationModel {
  final String id;
  final String userId;
  final Post? postId;
  final From from;
  final String fromUser;
  final String message;
  final bool isRead;
  final String type;
  final String createdAt;
  final String updatedAt;
  final int? v;

  NotificationModel({
    required this.id,
    required this.userId,
    this.postId,
    required this.from,
    required this.fromUser,
    required this.message,
    required this.isRead,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      userId: json['userId'],
      postId: json['postId'] != null ? Post.fromJson(json['postId']) : null,
      from: From.fromJson(json['from']),
      fromUser: json['fromUser'],
      message: json['message'],
      isRead: json['isRead'],
      type: json['type'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Post {
  final String id;
  final String image;

  Post({required this.id, required this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      image: json['image'],
    );
  }
}

class From {
  final String id;
  final String userName;
  final String email;
  final String password;
  final String? profilePic;
  final String? phone;
  final bool online;
  final bool blocked;
  final bool verified;
  final String role;
  final bool isPrivate;
  final String createdAt;
  final String updatedAt;
  final int? v;
  final String? bio;
  final String? name;
  final String? backGroundImage;

  From({
    required this.id,
    required this.userName,
    required this.email,
    required this.password,
    this.profilePic,
    this.phone,
    required this.online,
    required this.blocked,
    required this.verified,
    required this.role,
    required this.isPrivate,
    required this.createdAt,
    required this.updatedAt,
    this.v,
    this.bio,
    this.name,
    this.backGroundImage,
  });

  factory From.fromJson(Map<String, dynamic> json) {
    return From(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      profilePic: json['profilePic'],
      phone: json['phone'],
      online: json['online'],
      blocked: json['blocked'],
      verified: json['verified'],
      role: json['role'],
      isPrivate: json['isPrivate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      bio: json['bio'],
      name: json['name'],
      backGroundImage: json['backGroundImage'],
    );
  }
}