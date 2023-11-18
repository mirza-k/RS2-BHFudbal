class LoginRequest {
  String? username;
  String? password;
  bool? adminPage;

  LoginRequest({this.username, this.password, this.adminPage});

  Map<String, dynamic> toJson(LoginRequest instance) => <String, dynamic>{
        'username': instance.username,
        'password': instance.password,
        'adminPage': instance.adminPage
      };
}
