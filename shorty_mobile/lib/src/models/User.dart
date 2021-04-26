import 'package:shorty/views/util/CapExtension.dart';

class User {
  final String _id;
  final String _username;
  final String _firstName;
  final String _lastName;
  final String _email;

  get userFirstName => _firstName;
  get userSurname => _lastName;
  get userEmail => _email;
  get userID => _id;
  get userUsername => _username;

  User.fromJson(Map<String, dynamic> json)
      : _id = json['data']['user']['_id'] as String,
        _firstName = json['data']['user']['name'] as String,
        _lastName = json['data']['user']['surname'] as String,
        _email = json['data']['user']['email'] as String,
        _username = json['data']['user']['username'] as String;

  User.fromJsonForList(Map<String, dynamic> json)
      : _id = json['_id'] as String,
        _firstName = json['name'] as String,
        _lastName = json['surname'] as String,
        _email = json['email'] as String,
        _username = json['username'] as String;

  User.fromJsonForToken(Map<String, dynamic> json)
      : _id = json["data"]["profile"]['_id'] as String,
        _firstName = json["data"]["profile"]['name'] as String,
        _lastName = json["data"]["profile"]['surname'] as String,
        _email = json["data"]["profile"]['email'] as String,
        _username = json["data"]["profile"]['username'] as String;

  User.fromJsonForAppointment(Map<String, dynamic> json)
      : _id = json['_id'] as String,
        _firstName = json['name'] as String,
        _lastName = json['surname'] as String,
        _email = json['email'] as String,
        _username = json['username'] as String;

  String getFullName() {
    return userFirstName.toString().inCaps + " " + userSurname.toString().inCaps;
  }
}
