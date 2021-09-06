
class RowData {
  final String title;
  final User user;

  RowData({
    required this.title,
    required this.user,
  });

  factory RowData.fromJson(Map<String, dynamic> parsedJson){
    return RowData(
        title: parsedJson['title'],
        user: User.fromJson(parsedJson['user'])
    );
  }

//TODO: make toJson.
}

class User {

  final String id;
  final String profileImageUrl;

  User({
    required this.id,
    required this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      profileImageUrl: json['profile_image_url'],
    );
  }
}