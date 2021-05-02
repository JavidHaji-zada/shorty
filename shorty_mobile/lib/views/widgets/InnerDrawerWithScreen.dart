import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:shorty/service/WebServerService.dart';
import 'package:shorty/src/models/User.dart';
import 'package:shorty/views/util/ViewConstants.dart';

class InnerDrawerWithScreen extends StatefulWidget {
  final Widget scaffoldArea;

  const InnerDrawerWithScreen({Key key, @required this.scaffoldArea}) : super(key: key);

  @override
  _InnerDrawerWithScreenState createState() => _InnerDrawerWithScreenState();
}

class _InnerDrawerWithScreenState extends State<InnerDrawerWithScreen> {
  WebServerService _webServerService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<bool> initializeService() async {
    _webServerService = await WebServerService.getWebServerService();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        onTapClose: true, // default false
        swipe: true, // default true
        tapScaffoldEnabled: false,
        // TODO Boolean Value "false" is bugged, it rebuilds the scaffold, discards its state, waiting for update or fix
        //When setting the vertical offset, be sure to use only top or bottom
        offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.0),
        scale: IDOffset.horizontal(0.80), // set the offset in both directions
        proportionalChildArea: true, // default true
        borderRadius: 25, // default 0
        leftAnimationType: InnerDrawerAnimation.quadratic, // default static
        backgroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(1, 1),
            colors: <Color>[
              ViewConstants.myYellow.withOpacity(1),
              ViewConstants.myBlack.withOpacity(1),
            ],
          ),
        ), // default  Theme.of(context).backgroundColor
        //when a pointer that is in contact with the screen and moves to the right or left
        leftChild: Material(
            color: Colors.transparent,
            child: SafeArea(
                right: false,
                left: false,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              width: MediaQuery.of(context).size.width / 3,
                              child: Image.asset(
                                "assets/SHORTY_white.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ListTile(
                            title: Text("Log Out"),
                            leading: Icon(Icons.arrow_back_ios),
                            onTap: () {
                              WebServerService.getWebServerService().then((value) {
                                value.clearAllInfo();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, ViewConstants.welcomeRoute, (Route<dynamic> route) => false);
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                        )
                      ],
                    )
                ))), // required if rightChild is not set
        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
        scaffold: widget.scaffoldArea);
  }
}
