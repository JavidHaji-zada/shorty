import 'package:flutter/material.dart';
import 'package:shorty/service/WebServerService.dart';
import 'package:shorty/views/util/ViewConstants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  String _passwordErrorText;
  String _nameErrorText;
  String _emailErrorText;

  bool _emailValidate;
  bool _passwordValidate;
  bool _nameValidate;

  WebServerService _webServerService;

  final UnfocusDisposition disposition = UnfocusDisposition.scope;

  Future<bool> initializeService() async {
    _webServerService = await WebServerService.getWebServerService();
    if (_webServerService != null)
      return true;
    else
      return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordErrorText = "";
    _emailErrorText = "";
    _nameErrorText = "";

    _nameValidate = false;
    _emailValidate = false;
    _passwordValidate = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  Future<void> _signUp(BuildContext context) async {
    final String password = _passwordController.text;
    final String email = _emailController.text;
    final String name = _nameController.text;

    if (password.isNotEmpty && email.isNotEmpty && name.isNotEmpty) {
      final bool isCreated = await _webServerService.attemptUserSignUp(password, email, name);

      if (isCreated) {
        print("User is created");
        Navigator.pushNamed(context, ViewConstants.loginRoute);
      } else {
        final snackBar = SnackBar(
            duration: Duration(milliseconds: 1500),
            backgroundColor: ViewConstants.myBlack,
            content: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Something went wrong. Please try again.",
                style: TextStyle(color: ViewConstants.myWhite),
              ),
            ));
        Scaffold.of(context).showSnackBar(snackBar);
      }
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

  @override
  Widget build(BuildContext context) {
    final emailField = Theme(
      data: ThemeData(
        primaryColor: ViewConstants.myWhite,
        accentColor: ViewConstants.myWhite,
        cursorColor: ViewConstants.myWhite,
        hintColor: ViewConstants.myWhite,
      ),
      child: TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.mail,
              color: ViewConstants.myWhite,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ViewConstants.myWhite),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ViewConstants.myBlue),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: ViewConstants.myWhite),
            ),
            errorText: _emailValidate ? _emailErrorText : null,
            errorStyle: TextStyle(fontSize: 15, color: ViewConstants.myPink, fontWeight: FontWeight.w400),
            hintText: 'Type your e-mail',
            hintStyle: TextStyle(fontSize: 15, color: ViewConstants.myWhite, fontWeight: FontWeight.w400),
          ),
          style: TextStyle(color: ViewConstants.myWhite, fontWeight: FontWeight.w500, fontSize: 15),
          onEditingComplete: () {
            primaryFocus.unfocus(disposition: disposition);
            setState(() {
              _emailController.text.isEmpty ? _emailValidate = true : _emailValidate = false;
              _emailValidate ? _emailErrorText = "This field cannot be empty" : _emailErrorText = null;
            });
          }),
    );

    final nameField = Theme(
      data: ThemeData(
        primaryColor: ViewConstants.myWhite,
        accentColor: ViewConstants.myWhite,
        cursorColor: ViewConstants.myWhite,
        hintColor: ViewConstants.myWhite,
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _nameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.portrait,
            color: ViewConstants.myWhite,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myBlue),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myWhite),
          ),
          errorText: _nameValidate ? _nameErrorText : null,
          errorStyle: TextStyle(fontSize: 15, color: ViewConstants.myPink, fontWeight: FontWeight.w400),
          hintText: 'Type your first name',
          hintStyle: TextStyle(fontSize: 15, color: ViewConstants.myWhite, fontWeight: FontWeight.w400),
        ),
        style: TextStyle(color: ViewConstants.myWhite, fontWeight: FontWeight.w500, fontSize: 15),
        onEditingComplete: () {
          primaryFocus.unfocus(disposition: disposition);
          setState(() {
            _nameController.text.isEmpty ? _nameValidate = true : _nameValidate = false;
            _nameValidate ? _nameErrorText = "This field cannot be empty" : _nameErrorText = null;
          });
        },
      ),
    );

    final passwordField = Theme(
      data: ThemeData(
        primaryColor: ViewConstants.myWhite,
        cursorColor: ViewConstants.myWhite,
        hintColor: ViewConstants.myWhite,
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock_open,
            color: ViewConstants.myWhite,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myWhite),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myBlue),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: ViewConstants.myWhite),
          ),
          errorText: _passwordValidate ? _passwordErrorText : null,
          errorStyle: TextStyle(fontSize: 15, color: ViewConstants.myPink, fontWeight: FontWeight.w400),
          hintText: 'Type your password',
          hintStyle: TextStyle(fontSize: 15, color: ViewConstants.myWhite, fontWeight: FontWeight.w400),
        ),
        style: TextStyle(color: ViewConstants.myWhite, fontWeight: FontWeight.w500),
        onEditingComplete: () {
          primaryFocus.unfocus(disposition: disposition);
          setState(() {
            _passwordController.text.isEmpty ? _passwordValidate = true : _passwordValidate = false;
            _passwordValidate ? _passwordErrorText = "This field cannot be empty" : _passwordErrorText = null;
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
          if(snapshot.hasData) {
            return Column(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: nameField,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: passwordField,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: emailField,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      color: ViewConstants.myWhite,
                      child: StatefulBuilder(
                        builder: (BuildContext contextButton, void Function(void Function()) setState) {
                          return MaterialButton(
                            onPressed: () async {
                              await _signUp(contextButton);
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
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
