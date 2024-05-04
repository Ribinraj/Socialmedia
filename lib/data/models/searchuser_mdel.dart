class SearcUserModel {
    String id;
    String userName;
    String email;
    String profilePic;
    String phone;
    bool online;
    bool blocked;
    bool verified;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    Role role;
    bool isPrivate;
    String? bio;
    String? name;
    String backGroundImage;

    SearcUserModel({
        required this.id,
        required this.userName,
        required this.email,
        required this.profilePic,
        required this.phone,
        required this.online,
        required this.blocked,
        required this.verified,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.role,
        required this.isPrivate,
        this.bio,
        this.name,
        required this.backGroundImage,
    });

    factory SearcUserModel.fromJson(Map<String, dynamic> json) => SearcUserModel(
        id: json["_id"],
        userName: json["userName"],
        email: json["email"],
        profilePic: json["profilePic"],
        phone: json["phone"],
        online: json["online"],
        blocked: json["blocked"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        role: roleValues.map[json["role"]]!,
        isPrivate: json["isPrivate"],
        bio: json["bio"],
        name: json["name"],
        backGroundImage: json["backGroundImage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userName": userName,
        "email": email,
        "profilePic": profilePic,
        "phone": phone,
        "online": online,
        "blocked": blocked,
        "verified": verified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "role": roleValues.reverse[role],
        "isPrivate": isPrivate,
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
