import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shorty/service/WebServerService.dart';
import 'package:shorty/views/util/ViewConstants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  static List<Widget> _homepageTabs;
  static List<CustomNavigationBarItem> bottomIconButtons;

  PageController _pageController;
  WebServerService _webServerService;
  int _currentIndex;

  @override
  void initState() {
    _pageController = PageController(initialPage: 2);
    _currentIndex = _pageController.initialPage;
    super.initState();
  }

  Future<bool> initializeService() async {
    // Wait for Web Server Service to be created
    try {
      _webServerService = await WebServerService.getWebServerService();

      bottomIconButtons = <CustomNavigationBarItem>[
        CustomNavigationBarItem(icon: Icons.all_inclusive),
        CustomNavigationBarItem(icon: Icons.add),
        CustomNavigationBarItem(icon: Icons.access_time),
        CustomNavigationBarItem(icon: Icons.chat),
      ];
    } catch (e) {
      print(e);
    }
    return true;
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeService(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == true) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: ViewConstants.myWhite,
            bottomNavigationBar: StatefulBuilder(
              builder: (context, StateSetter stateSetter) {
                return CustomNavigationBar(
                  scaleFactor: 0.2,
                  iconSize: 25.0,
                  selectedColor: ViewConstants.myBlue,
                  strokeColor: ViewConstants.myBlue,
                  unSelectedColor: ViewConstants.myWhite,
                  backgroundColor: ViewConstants.myBlack,
                  items: bottomIconButtons,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                );
              },
            ),
            body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _homepageTabs,
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
