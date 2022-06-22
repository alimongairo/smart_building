// Here is description of class User

class User {
  int userID = -1;
  String name = "";
  String email = "";
  String phone = "";
  String type = "";
  String profilePhoto = "";
  String token = "";
  String renewalToken = "";

  User(
      {this.userID = -1,
      this.name = "",
      this.email = "",
      this.phone = "",
      this.type = "",
      this.profilePhoto = "",
      this.token = "",
      this.renewalToken = ""});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userID: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        profilePhoto: responseData['profilePhoto'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']);
  }
}
