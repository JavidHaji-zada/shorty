import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shorty/service/util/ServiceConstants.dart';
import 'package:shorty/view_models/AdminLinkListViewModel.dart';
import 'package:shorty/views/util/ViewConstants.dart';

class AdminAnalysisPage extends StatefulWidget {
  @override
  _AdminAnalysisPageState createState() => _AdminAnalysisPageState();
}

class _AdminAnalysisPageState extends State<AdminAnalysisPage> {
  AdminLinkListViewModel _adminLinkListViewModel;

  List<Color> _cardBackgroundColors;

  ScrollController _scrollController;

  final ValueNotifier<double> _scrollOffset = ValueNotifier<double>(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _adminLinkListViewModel = AdminLinkListViewModel();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      _scrollOffset.value = _scrollController.offset;
    });

    _cardBackgroundColors = [
      ViewConstants.myYellow,
      ViewConstants.myPink,
      ViewConstants.myWhite,
      ViewConstants.myGreen,
      ViewConstants.myLightGrey
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment(5, 5), colors: [ViewConstants.myWhite, ViewConstants.myYellow]),
      ),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.1,
            pinned: false,
            stretch: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: ViewConstants.myBlack,
            ),
            flexibleSpace: SafeArea(
              child: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text("User Links",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 30, color: ViewConstants.myBlack, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
                stretchModes: [
                  StretchMode.zoomBackground,
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              elevation: 4,
              shadowColor: ViewConstants.myBlue,
              color: ViewConstants.myWhite,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Container(
                padding: EdgeInsets.all(18),
                height: MediaQuery.of(context).size.height / 7,
                decoration: BoxDecoration(color: ViewConstants.myYellow.withOpacity(0.4)),
                child: Center(
                  child: AutoSizeText(
                    "From the list below, you can find the registered links of all the users for fast and efficient access to the URLs.",
                    maxLines: 4,
                    minFontSize: 16,
                    maxFontSize: 20,
                    stepGranularity: 1,
                    style: GoogleFonts.lato(fontSize: 16, color: ViewConstants.myGrey),
                  ),
                ),
              ),
            ),
          ),
          ChangeNotifierProvider<AdminLinkListViewModel>(
            create: (context) => _adminLinkListViewModel,
            child: Consumer<AdminLinkListViewModel>(
              builder: (context, model, child) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Color _backgroundColor = _cardBackgroundColors.elementAt(index % 5);

                      return ValueListenableBuilder(
                        child: Builder(
                          builder: (BuildContext builderContext) {
                            return Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: ViewConstants.myBlack.withOpacity(0.75),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("Alias: ",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 18,
                                                            color: ViewConstants.myWhite,
                                                            fontWeight: FontWeight.bold)),
                                                    Padding(
                                                        padding: EdgeInsets.only(top: 3),
                                                        child: Text("shorty.co/" +
                                                            _adminLinkListViewModel.getLinkByIndex(index).getAlias))
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: ViewConstants.myBlack.withOpacity(0.75),
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text("URL: ",
                                                        style: GoogleFonts.lato(
                                                            fontSize: 18,
                                                            color: ViewConstants.myWhite,
                                                            fontWeight: FontWeight.bold)),
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 3),
                                                      child: Text(_adminLinkListViewModel.getLinkByIndex(index).getURL),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width / 5,
                                          decoration: BoxDecoration(
                                            color: ViewConstants.myBlack,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(20),
                                          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                                          child: Center(
                                            child: Text(
                                              _adminLinkListViewModel.getLinkByIndex(index).getNumberOfClicks.toString(),
                                              style: GoogleFonts.lato(fontSize: 20, color: ViewConstants.myWhite),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ViewConstants.myBlack.withOpacity(0.75),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("User ID: ",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: ViewConstants.myWhite,
                                                    fontWeight: FontWeight.bold)),
                                            Text(_adminLinkListViewModel.getLinkByIndex(index).getUserID,
                                                style: GoogleFonts.lato(fontSize: 12, color: ViewConstants.myWhite))
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 3,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: ViewConstants.myBlack.withOpacity(0.75),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Link ID: ",
                                                style: GoogleFonts.lato(
                                                    fontSize: 15,
                                                    color: ViewConstants.myWhite,
                                                    fontWeight: FontWeight.bold)),
                                            Text(_adminLinkListViewModel.getLinkByIndex(index).getLinkID,
                                                style: GoogleFonts.lato(fontSize: 12, color: ViewConstants.myWhite)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 2,
                                  color: ViewConstants.myBlack.withOpacity(0.5),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ViewConstants.myBlack.withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: FlatButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onPressed: () {
                                            String alias = _adminLinkListViewModel.getLinkByIndex(index).getAlias;

                                            String serviceAddress = ServiceConstants.serverAddress;

                                            Clipboard.setData(new ClipboardData(text: "$serviceAddress/$alias"));

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
                                          },
                                          child: Text("Copy URL"),
                                        ),
                                      ),
                                      Expanded(
                                        child: FlatButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onPressed: () async {
                                            bool isDeleted = await _adminLinkListViewModel.deleteLink(index);

                                            if (isDeleted) {
                                              final snackBar = SnackBar(
                                                  duration: Duration(milliseconds: 1500),
                                                  backgroundColor: ViewConstants.myYellow,
                                                  content: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "Your link is deleted successfully.",
                                                      style: TextStyle(color: ViewConstants.myWhite),
                                                    ),
                                                  ));
                                              Scaffold.of(context).showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                  duration: Duration(milliseconds: 1500),
                                                  backgroundColor: ViewConstants.myYellow,
                                                  content: Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Text(
                                                      "Ops. The link could not be deleted.",
                                                      style: TextStyle(color: ViewConstants.myWhite),
                                                    ),
                                                  ));
                                              Scaffold.of(context).showSnackBar(snackBar);
                                            }
                                          },
                                          child: Text("Delete URL"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        builder: (context, value, child) {
                          double _colorValue;
                          double _changeLength = 1;
                          double _div = value / (255 * _changeLength);

                          if (_div.toInt().isEven) {
                            _colorValue = (value / _changeLength).abs() % 255;
                          } else {
                            _colorValue = 255 - (value / _changeLength) % 255;
                          }

                          double height;

                          if (MediaQuery.of(context).size.height > 800) {
                            height = MediaQuery.of(context).size.height * 0.8;
                          } else {
                            height = MediaQuery.of(context).size.height;
                          }

                          Color _redAppliedColor = _backgroundColor.withRed(_colorValue.toInt());

                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            color: ViewConstants.myWhite.withOpacity(0.75),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: height * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(5, 5),
                                    colors: [ViewConstants.myGreyBlue, _redAppliedColor, _redAppliedColor]),
                              ),
                              child: child,
                            ),
                          );
                        },
                        valueListenable: _scrollOffset,
                      );
                    },
                    childCount: _adminLinkListViewModel.getListLength(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
