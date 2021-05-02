class ShortLink {
  final String _userID;
  final String _linkID;
  final String _alias;
  final String _url;
  final int _numberOfClicks;

  get getUserID => _userID;
  get getLinkID => _linkID;
  get getAlias => _alias;
  get getURL => _url;
  get getNumberOfClicks => _numberOfClicks;

  ShortLink.fromJson(Map<String, dynamic> json)
      : _userID = json["userID"] as String,
        _linkID = json["id"] as String,
        _alias = json["alias"] as String,
        _url = json["url"] as String,
        _numberOfClicks = json["numberOfClicks"] as int;
}