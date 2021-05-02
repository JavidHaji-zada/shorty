import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorty/service/WebServerService.dart';
import 'package:shorty/service/util/ServiceConstants.dart';
import 'package:shorty/views/util/ViewConstants.dart';
import 'package:flutter/services.dart';

class AnonymousPage extends StatefulWidget {
  @override
  _AnonymousPageState createState() => _AnonymousPageState();
}

class _AnonymousPageState extends State<AnonymousPage> {
  final _urlController = TextEditingController();
  String _urlErrorText;
  bool _urlValidate;

  WebServerService _webServerService;

  final UnfocusDisposition disposition = UnfocusDisposition.scope;

  Future<bool> initializeService() async {
    _webServerService = await WebServerService.getWebServerService();
    if (_webServerService != null)
      return true;
    else
      return false;
  }

  Future<void> _getURLAnonymous(BuildContext context) async {
    final String urlText = _urlController.text;

    if (urlText.isNotEmpty) {
      final String shortURL = await _webServerService.getURLRedirectAnonymous(urlText);

      if (shortURL != null) {
        bool isCopied = await _showMyDialog(context, shortURL);

        _urlController.text = "https://";

        if (isCopied) {
          final snackBar = SnackBar(
              duration: Duration(milliseconds: 1500),
              backgroundColor: ViewConstants.myYellow,
              content: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Your link is copied to your clipboard.",
                  style: TextStyle(color: ViewConstants.myWhite),
                ),
              ));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      } else {}
    } else {
      final snackBar = SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: ViewConstants.myBlack,
          content: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "Do not forget to fill out all the fields.",
              style: TextStyle(color: ViewConstants.myWhite),
            ),
          ));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  Future<bool> _showMyDialog(context, shortURL) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ViewConstants.myBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(20),
          title: Text('Here is Your Link!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('shorty.co/$shortURL'),
                Text(""),
                Text('By clicking the "Copy" button below, you can copy the link.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Copy'),
              onPressed: () {
                String serverAddress = ServiceConstants.serverAddress;

                Clipboard.setData(new ClipboardData(text: "$serverAddress/$shortURL"));

                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _urlController.text = "https://";
    _urlErrorText = "";
    _urlValidate = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _urlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final urlField = Theme(
      data: ThemeData(
        primaryColor: ViewConstants.myWhite,
        accentColor: ViewConstants.myWhite,
        cursorColor: ViewConstants.myWhite,
        hintColor: ViewConstants.myWhite,
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _urlController,
        minLines: 7,
        maxLines: 10,
        textAlign: TextAlign.center,
        cursorColor: ViewConstants.myWhite,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myBlack, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myYellow, width: 2),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myBlack, width: 2),
          ),
          errorText: _urlValidate ? _urlErrorText : null,
          errorStyle: TextStyle(fontSize: 15, color: ViewConstants.myPink, fontWeight: FontWeight.w400),
        ),
        style: TextStyle(color: ViewConstants.myBlack, fontWeight: FontWeight.w500, fontSize: 18),
        onEditingComplete: () {
          primaryFocus.unfocus(disposition: disposition);
          setState(() {
            _urlController.text.isEmpty ? _urlValidate = true : _urlValidate = false;
            _urlValidate ? _urlErrorText = "This field cannot be empty" : _urlErrorText = null;
          });
        },
      ),
    );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: ViewConstants.myBlack,
      body: FutureBuilder(
        future: initializeService(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
              child: Container(
                decoration: BoxDecoration(
                  color: ViewConstants.myWhite,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Image.asset(
                          "assets/SHORTY_black.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ViewConstants.myBlack),
                            child: Center(
                              child: Text("Type your link below. We will create the link for you!",
                                  textAlign: TextAlign.center,
                                  style: ViewConstants.fieldStyle
                                      .copyWith(fontSize: 20, color: ViewConstants.myWhite, fontWeight: FontWeight.w600)),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Stack(
                              children: [
                                Center(
                                  child: Opacity(
                                    opacity: 0.5,
                                    child: Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                                      child: Image.asset(
                                        "assets/link_photo.png",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: urlField,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Material(
                          clipBehavior: Clip.hardEdge,
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(10),
                          color: ViewConstants.myYellow,
                          child: StatefulBuilder(
                            builder: (BuildContext context, void Function(void Function()) setState) {
                              return MaterialButton(
                                onPressed: () async {
                                  await _getURLAnonymous(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text("Create the Link",
                                      textAlign: TextAlign.center,
                                      style: ViewConstants.fieldStyle.copyWith(
                                          fontSize: 15, color: ViewConstants.myWhite, fontWeight: FontWeight.bold)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
