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

  Args({
    required this.userName,
  });

  factory Args.fromJson(Map<String, dynamic> json) {
    return Args(
      userName: json['userName'],
    );
  }
}