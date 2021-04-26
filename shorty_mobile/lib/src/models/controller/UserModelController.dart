import 'package:shorty/src/models/User.dart';
import 'package:shorty/src/models/Admin.dart';

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

  static Admin createAdminFromJSON(dynamic decodedBody) {
    try {
      var admin = Admin.fromJson(decodedBody);
      return admin;
    } catch (e) {
      print(e);
      throw Exception("");
    }
  }
}
