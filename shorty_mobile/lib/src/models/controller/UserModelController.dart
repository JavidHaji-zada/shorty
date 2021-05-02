import 'package:shorty/src/models/User.dart';

class UserModelController {
  static User createUserFromJSON(dynamic decodedBody) {
    try {
      var user = User.fromJson(decodedBody);
      return user;
    } catch (e) {
      print(e);
      throw Exception("");
    }
  }

  static User createUserFromJSONForToken(dynamic decodedBody) {
    try {
      var user = User.fromJsonForToken(decodedBody);
      return user;
    } catch (e) {
      print(e);
      throw Exception("");
    }
  }
}
