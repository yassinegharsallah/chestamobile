class User {
  String username;
  String email;
  String token;
  User(
      {this.username , this.email , this.token});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
    );
  }

}