import 'package:shorty/views/util/CapExtension.dart';

class User {
  final String _name;
  final String _email;
  final String _role;

  get userName => _name;
  get userEmail => _email;
  get userRole => _role;

  User.fromJson(Map<String, dynamic> json) :
        _name = json['user']['name'] as String,
        _email = json['user']['email'] as String,
        _role = json['user']['role'] as String;

  User.fromJsonForToken(Map<String, dynamic> json) :
        _name = json['name'] as String,
        _email = json['email'] as String,
        _role = json['role'] as String;

  String getFullName() {
    return _name.toString().inCaps;
  }
}
