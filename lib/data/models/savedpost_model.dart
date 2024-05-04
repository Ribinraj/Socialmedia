// class SavedpostModel {
//     UserId userId;
//     PostId postId;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;

//     SavedpostModel({
//         required this.userId,
//         required this.postId,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     factory SavedpostModel.fromJson(Map<String, dynamic> json) => SavedpostModel(
//         userId: UserId.fromJson(json["userId"]),
//         postId: PostId.fromJson(json["postId"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId.toJson(),
//         "postId": postId.toJson(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class PostId {
//     String id;
//     String userId;
//     String image;
//     String description;
//     List<String> likes;
//     bool hidden;
//     bool blocked;
//     List<dynamic> tags;
//     List<dynamic> taggedUsers;
//     DateTime date;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;

//     PostId({
//         required this.id,
//         required this.userId,
//         required this.image,
//         required this.description,
//         required this.likes,
//         required this.hidden,
//         required this.blocked,
//         required this.tags,
//         required this.taggedUsers,
//         required this.date,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     factory PostId.fromJson(Map<String, dynamic> json) => PostId(
//         id: json["_id"],
//         userId: json["userId"],
//         image: json["image"],
//         description: json["description"],
//         likes: List<String>.from(json["likes"].map((x) => x)),
//         hidden: json["hidden"],
//         blocked: json["blocked"],
//         tags: List<dynamic>.from(json["tags"].map((x) => x)),
//         taggedUsers: List<dynamic>.from(json["taggedUsers"].map((x) => x)),
//         date: DateTime.parse(json["date"]),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userId": userId,
//         "image": image,
//         "description": description,
//         "likes": List<dynamic>.from(likes.map((x) => x)),
//         "hidden": hidden,
//         "blocked": blocked,
//         "tags": List<dynamic>.from(tags.map((x) => x)),
//         "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x)),
//         "date": date.toIso8601String(),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class UserId {
//     String id;
//     String userName;
//     String email;
//     String password;
//     String phone;
//     bool online;
//     bool blocked;
//     bool verified;
//     String role;
//     bool isPrivate;
//     DateTime createdAt;
//     DateTime updatedAt;
//     int v;
//     String bio;
//     String name;
//     String profilePic;
//     String backGroundImage;

//     UserId({
//         required this.id,
//         required this.userName,
//         required this.email,
//         required this.password,
//         required this.phone,
//         required this.online,
//         required this.blocked,
//         required this.verified,
//         required this.role,
//         required this.isPrivate,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.bio,
//         required this.name,
//         required this.profilePic,
//         required this.backGroundImage,
//     });

//     factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//         id: json["_id"],
//         userName: json["userName"],
//         email: json["email"],
//         password: json["password"],
//         phone: json["phone"],
//         online: json["online"],
//         blocked: json["blocked"],
//         verified: json["verified"],
//         role: json["role"],
//         isPrivate: json["isPrivate"],
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         bio: json["bio"],
//         name: json["name"],
//         profilePic: json["profilePic"],
//         backGroundImage: json["backGroundImage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "userName": userName,
//         "email": email,
//         "password": password,
//         "phone": phone,
//         "online": online,
//         "blocked": blocked,
//         "verified": verified,
//         "role": role,
//         "isPrivate": isPrivate,
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//         "bio": bio,
//         "name": name,
//         "profilePic": profilePic,
//         "backGroundImage": backGroundImage,
//     };
// }
class SavedpostModel {
    String userId;
    PostId postId;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    SavedpostModel({
        required this.userId,
        required this.postId,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory SavedpostModel.fromJson(Map<String, dynamic> json) => SavedpostModel(
        userId: json["userId"],
        postId: PostId.fromJson(json["postId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "postId": postId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class PostId {
    String id;
    UserId userId;
    String image;
    String description;
    List<String> likes;
    bool hidden;
    bool blocked;
    List<dynamic> taggedUsers;
    DateTime date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    List<dynamic> tags;

    PostId({
        required this.id,
        required this.userId,
        required this.image,
        required this.description,
        required this.likes,
        required this.hidden,
        required this.blocked,
        required this.taggedUsers,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.tags,
    });

    factory PostId.fromJson(Map<String, dynamic> json) => PostId(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        image: json["image"],
        description: json["description"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        hidden: json["hidden"],
        blocked: json["blocked"],
        taggedUsers: List<dynamic>.from(json["taggedUsers"].map((x) => x)),
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "image": image,
        "description": description,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "hidden": hidden,
        "blocked": blocked,
        "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x)),
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "tags": List<dynamic>.from(tags.map((x) => x)),
    };
}

class UserId {
    String id;
    String userName;
    String email;
    String password;
    String profilePic;
    String phone;
    bool online;
    bool blocked;
    bool verified;
    String role;
    bool isPrivate;
    String backGroundImage;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String bio;
    String name;

    UserId({
        required this.id,
        required this.userName,
        required this.email,
        required this.password,
        required this.profilePic,
        required this.phone,
        required this.online,
        required this.blocked,
        required this.verified,
        required this.role,
        required this.isPrivate,
        required this.backGroundImage,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.bio,
        required this.name,
    });

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        password: json["password"],
        profilePic: json["profilePic"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        role: json["role"],
        isPrivate: json["isPrivate"],
        backGroundImage: json["backGroundImage"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "profilePic": profilePic,
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "role": role,
        "isPrivate": isPrivate,
        "backGroundImage": backGroundImage,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
    };
}
