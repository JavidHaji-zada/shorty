library services;

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shorty/service/util/ServiceConstants.dart';
import 'package:shorty/service/util/ServiceErrorHandling.dart';
import 'package:shorty/src/models/ShortLink.dart';
import 'package:shorty/src/models/User.dart';
import 'package:shorty/src/models/controller/UserModelController.dart';
import 'package:shorty/src/models/util/ModelConstants.dart';

class WebServerService {
  static String _serverAddress;
  static WebServerService _serverService;
  static FlutterSecureStorage _secureStorage;
  static User _currentUser;

  get currentUser => _currentUser;

  static Future<WebServerService> getWebServerService() async {
    if (_serverAddress == null) {
      _serverAddress = ServiceConstants.serverAddress;
    }
    if (_serverService == null) {
      print("Empty Service for Web Service. Creating a new one.");
      _serverService = new WebServerService();
    }
    if (_secureStorage == null) {
      print("Empty Storage for Storage Service. Creating a new one.");
      _secureStorage = new FlutterSecureStorage();
    }

    return _serverService;
  }

  Future<String> attemptLogin(String email, String password) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET', Uri.parse('$_serverAddress/users'));

      request.body = '''{
      \r\n    "email":"$email",
      \r\n    "password":"$password"
      \r\n
      }''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(await response.stream.bytesToString());

        print(data);

        saveCurrentUserInformation(data);

        return ServiceErrorHandling.successfulStatusCode;
      } else {
        print(response.reasonPhrase);
        return "False";
      }
    } catch (error) {
      print(error);
      return ServiceErrorHandling.serverNotRespondingError;
    }
  }

  Future<String> getURLRedirectAnonymous(String url) async {
    final String currentUserToken = await getToken();

    if (currentUserToken == null) {
      final message = jsonEncode({
        "alias": "",
        "url": url,
      });

      try {
        var response =
            await http.post('$_serverAddress/redirects', headers: {'Content-Type': 'application/json'}, body: message);

        dynamic data = jsonDecode(response.body);

        if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
          return data["alias"];
        } else
          return null;
      } catch (e) {
        throw ServiceErrorHandling.couldNotCreateRequestError;
      }
    } else {
      final message = jsonEncode({
        "alias": "",
        "url": url,
      });

      try {
        var response = await http.post('$_serverAddress/redirects',
            headers: {'Content-Type': 'application/json', 'sessionID': '$currentUserToken'}, body: message);

        dynamic data = jsonDecode(response.body);

        if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
          return data["alias"];
        } else
          return null;
      } catch (e) {
        throw ServiceErrorHandling.couldNotCreateRequestError;
      }
    }
  }

  Future<String> getURLRedirect(String alias, String url) async {
    final String currentUserToken = await getToken();

    final message = jsonEncode({
      "alias": alias,
      "url": url,
    });

    try {
      var response = await http.post('$_serverAddress/redirects',
          headers: {'Content-Type': 'application/json', 'sessionID': '$currentUserToken'}, body: message);

      dynamic data = jsonDecode(response.body);

      if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
        return data["alias"];
      } else
        return null;
    } catch (e) {
      throw ServiceErrorHandling.couldNotCreateRequestError;
    }
  }

  Future<bool> attemptUserSignUp(String password, String email, String name) async {
    final message = jsonEncode({"name": name, "email": email, "password": password});

    try {
      var response = await http.post('$_serverAddress/users', headers: {'Content-Type': 'application/json'}, body: message);

      dynamic data = jsonDecode(response.body);

      print(data);

      if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
        return true;
      } else
        return false;
    } catch (e) {
      throw ServiceErrorHandling.couldNotCreateRequestError;
    }
  }

  bool saveCurrentUserInformation(dynamic _decodedBody) {
    if (_decodedBody != null) {
      try {
        _currentUser = UserModelController.createUserFromJSON(_decodedBody);
        _setToken(_decodedBody["sessionID"]);
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    } else {
      return false;
    }
  }

  Future<String> checkUserByCurrentToken() async {
    final String currentUserToken = await getToken();

    if (currentUserToken != null) {
      print("User Token: " + currentUserToken);

      try {
        var response = await http.get(
          '$_serverAddress/users/user',
          headers: {'Content-Type': 'application/json', 'sessionID': '$currentUserToken'},
        );

        if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
          bool isUserCreated = saveCurrentUserInformationForToken(response.body);

          if (isUserCreated) {
            return ServiceErrorHandling.successfulStatusCode;
          } else {
            return ServiceErrorHandling.userInformationError;
          }
        } else {
          return ServiceErrorHandling.unsuccessfulStatusCode;
        }
      } catch (error) {
        print(error);
        return ServiceErrorHandling.serverNotRespondingError;
      }
    } else {
      return ServiceErrorHandling.noTokenError;
    }
  }

  bool saveCurrentUserInformationForToken(dynamic responseBody) {
    dynamic _decodedBody = jsonDecode(responseBody);

    if (_decodedBody["role"] != null) {
      try {
        _currentUser = UserModelController.createUserFromJSONForToken(_decodedBody);
        return true;
      } catch (error) {
        print(ServiceErrorHandling.userInformationError);
        print(error);
      }
      return false;
    } else {
      print(ServiceErrorHandling.noRoleError);
      return false;
    }
  }

  Future<List<ShortLink>> getLinkList() async {
    final String currentUserToken = await getToken();

    if (currentUserToken != null) {
      List<ShortLink> _linkList = List<ShortLink>();

      try {
        var response = await http.get('$_serverAddress/redirects',
            headers: {'Content-Type': 'application/json', 'sessionID': '$currentUserToken'});

        if (response.statusCode == ServiceConstants.STATUS_SUCCESS_CODE) {
          dynamic _decodedBody = jsonDecode(response.body);

          int numberOfLinks = _decodedBody.length;

          _linkList = List<ShortLink>.generate(numberOfLinks, (index) => ShortLink.fromJson(_decodedBody[index]));

          return _linkList;
        } else {
          throw ServiceErrorHandling.couldNotCreateRequestError;
        }
      } catch (e) {
        print(e);
        throw ServiceErrorHandling.serverNotRespondingError;
      }
    } else {
      throw ServiceErrorHandling.noTokenError;
    }
  }

  Future<String> getToken() async {
    String token = await _secureStorage.read(key: "token");

    return token;
  }

  void _setToken(String token) async {
    await _secureStorage.write(key: "token", value: token);

    print("User Token is set to: " + token);
  }

  Future<void> clearAllInfo() async {
    _currentUser = null;
    return _secureStorage.deleteAll();
  }

  Future<bool> deleteLink(String alias) async {
    final String currentUserToken = await getToken();

    if (currentUserToken != null) {
      try {
        var request = http.Request('DELETE', Uri.parse('$_serverAddress/redirects/$alias'));
        request.headers.addAll(<String, String>{'Content-Type': 'application/json', 'sessionID': '$currentUserToken'});

        final response = await request.send();

        print(response.statusCode);

        if (response.statusCode == ServiceConstants.STATUS_DELETE_SUCCESS_CODE) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print(e);
        throw ServiceErrorHandling.serverNotRespondingError;
      }
    } else {
      print(ServiceErrorHandling.tokenEmptyError);
      return false;
    }
  }
}
