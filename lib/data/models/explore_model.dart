class ExplorepostModel {
    String id;
    UserId userId;
    String image;
    String description;
    List<String> likes;
    bool hidden;
    bool blocked;
    List<String> tags;
    List<TaggedUser> taggedUsers;
    DateTime date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    ExplorepostModel({
        required this.id,
        required this.userId,
        required this.image,
        required this.description,
        required this.likes,
        required this.hidden,
        required this.blocked,
        required this.tags,
        required this.taggedUsers,
        required this.date,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory ExplorepostModel.fromJson(Map<String, dynamic> json) => ExplorepostModel(
        id: json["_id"],
        userId: UserId.fromJson(json["userId"]),
        image: json["image"],
        description: json["description"],
        likes: List<String>.from(json["likes"].map((x) => x)),
        hidden: json["hidden"],
        blocked: json["blocked"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        taggedUsers: List<TaggedUser>.from(json["taggedUsers"].map((x) => TaggedUser.fromJson(x))),
        date: DateTime.parse(json["date"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId.toJson(),
        "image": image,
        "description": description,
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "hidden": hidden,
        "blocked": blocked,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "taggedUsers": List<dynamic>.from(taggedUsers.map((x) => x.toJson())),
        "date": date.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class TaggedUser {
    String id;
    String userName;

    TaggedUser({
        required this.id,
        required this.userName,
    });

    factory TaggedUser.fromJson(Map<String, dynamic> json) => TaggedUser(
        id: json["_id"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
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
    Role role;
    bool isPrivate;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    String? bio;
    String? name;
    String backGroundImage;

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
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        this.bio,
        this.name,
        required this.backGroundImage,
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
        role: roleValues.map[json["role"]]!,
        isPrivate: json["isPrivate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        bio: json["bio"],
        name: json["name"],
        backGroundImage: json["backGroundImage"],
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
        "role": roleValues.reverse[role],
        "isPrivate": isPrivate,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "bio": bio,
        "name": name,
        "backGroundImage": backGroundImage,
    };
}

enum Role {
    user
}

final roleValues = EnumValues({
    "User": Role.user
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}