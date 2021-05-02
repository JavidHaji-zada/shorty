import 'package:flutter/material.dart';
import 'package:shorty/service/WebServerService.dart';
import 'package:shorty/service/util/ServiceErrorHandling.dart';
import 'package:shorty/src/models/ShortLink.dart';

class UserLinkListViewModel extends ChangeNotifier {
  WebServerService _webServerService;

  List<ShortLink> _linkList;

  UserLinkListViewModel() {
    _linkList = List<ShortLink>();

    initializeService();
  }

  ShortLink getLinkByIndex(int index) {
    return _linkList[index];
  }

  int getListLength() {
    if (_linkList.isNotEmpty)
      return _linkList.length;
    else
      return 0;
  }

  initializeService() async {
    if (_webServerService == null) _webServerService = await WebServerService.getWebServerService();

    try {
      _linkList = await _webServerService.getLinkList();

      if (_linkList.isNotEmpty) {
        print("Links are fetched successfully.");
        notifyListeners();
      } else {
        print("Link List is empty.");
        notifyListeners();
      }
    } catch (error) {
      print(error);
      print(ServiceErrorHandling.serverNotRespondingError);
    }
  }

  Future<bool> deleteLink(int index) async {
    if (_webServerService == null) _webServerService = await WebServerService.getWebServerService();

    try {
      bool isDeleted = await _webServerService.deleteLink(getLinkByIndex(index).getAlias);

      if (isDeleted) {
        initializeService();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      print(ServiceErrorHandling.serverNotRespondingError);
      return false;
    }
  }
}
