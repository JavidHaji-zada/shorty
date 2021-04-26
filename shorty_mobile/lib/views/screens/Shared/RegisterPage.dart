import 'package:flutter/material.dart';
import 'package:shorty/views/util/ViewConstants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ViewConstants.myBlack,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
              child: Image.asset(
                "assets/SHORTY_white.png",
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  color: ViewConstants.myWhite,
                  child: MaterialButton(
                    onPressed: () {

                    },
                    child: Row(children: [
                      Expanded(
                        child: Text("Create an Account",
                            textAlign: TextAlign.center,
                            style: ViewConstants.fieldStyle
                                .copyWith(fontSize: 15, color: ViewConstants.myBlack, fontWeight: FontWeight.bold)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ViewConstants.myBlack,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
