// https://flutter.dev/docs/development/data-and-backend/json

class ApiResponse {
  final String url;
  final Args args;

  ApiResponse({
    required this.url,
    required this.args,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> parsedJson){
    return ApiResponse(
        url: parsedJson['url'],
        args: Args.fromJson(parsedJson['args'])
    );
  }

}

class Args {

  final String userName;
  final String password;

  Args({
    required this.userName,
    required this.password,
  });

  factory Args.fromJson(Map<String, dynamic> json) {
    return Args(
      userName: json['userName'],
      password: json['password'],
    );
  }
}