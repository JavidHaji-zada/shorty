import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shorty/views/util/ViewConstants.dart';
import 'package:shorty/views/widgets/LoadingIndicator.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Timer _tabTimer;

  final List<Widget> tabInformation = [
    new Text("Shorten your links.",
        style: TextStyle(fontSize: 45, color: ViewConstants.myWhite, fontWeight: FontWeight.bold)),
    new Text(
      "Create your own custom URLs!",
      style: TextStyle(fontSize: 45, color: ViewConstants.myWhite, fontWeight: FontWeight.bold),
    ),
    new Text(
      "Share with your friends.",
      style: TextStyle(fontSize: 45, color: ViewConstants.myWhite, fontWeight: FontWeight.bold),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    _tabTimer = Timer.periodic(
        Duration(seconds: 4),
        (Timer t) => setState(() {
              _tabController.index = (_tabController.index + 1) % 3;
            }));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _tabTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ViewConstants.myBlack,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: LoadingIndicator(),
            ),
          ),
          Column(
            children: [
              SafeArea(
                top: true,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Image.asset(
                      "assets/SHORTY_white.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              width: constraints.maxWidth * 0.75,
                              height: constraints.maxHeight / 3,
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(10.0),
                                color: ViewConstants.myBlack,
                                child: MaterialButton(
                                  padding: EdgeInsets.zero,
                                  minWidth: constraints.maxWidth * 0.75,
                                  height: constraints.maxHeight / 3,
                                  onPressed: () {
                                    Navigator.pushNamed(context, ViewConstants.loginRoute);
                                  },
                                  child: Text("Log in",
                                      textAlign: TextAlign.center,
                                      style: ViewConstants.fieldStyle.copyWith(
                                          fontSize: 18, color: ViewConstants.myWhite, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, ViewConstants.registerRoute);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: SafeArea(
                                  top: false,
                                  bottom: true,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("You don't have an account?",
                                          style: TextStyle(
                                              fontSize: 12, color: ViewConstants.myBlack, fontWeight: FontWeight.w400)),
                                      Text("\t\tSign up here",
                                          style: TextStyle(
                                              fontSize: 12, color: ViewConstants.myBlack, fontWeight: FontWeight.w900)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.40,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Center(
                child: AnimatedBuilder(
                  animation: _tabController.animation,
                  builder: (context, snapshot) {
                    return tabInformation[_tabController.index];
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
