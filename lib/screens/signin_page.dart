import 'dart:async';

import 'package:autoinvestor_bot/screens/user_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import '../apis/EEApi.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isPasswordVisible = true;
  Timer timer;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            width: 24,
            color: Colors.white,
            image: Svg('assets/images/back_arrow.svg'),
          ),
        ),
      ),
      body: SafeArea(
        //to make page scrollable
        child: this._buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      reverse: true,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back.",
                        style: kHeadline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You've been missed!",
                        style: kBodyText2,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      MyTextField(
                        hintText: 'Phone, email or username',
                        inputType: TextInputType.text,
                      ),
                      MyPasswordField(
                        isPasswordVisible: isPasswordVisible,
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont't have an account? ",
                      style: kBodyText,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   CupertinoPageRoute(
                        //     builder: (context) => RegisterPage(),
                        //   ),
                        // );
                        this.scaffoldKey.currentState.showSnackBar(SnackBar(
                              duration: Duration(seconds: 1),
                              content: Row(
                                children: <Widget>[
                                  Text("Work in progress..."),
                                ],
                              ),
                            ));
                      },
                      child: Text(
                        'Register',
                        style: kBodyText.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextButton(
                  buttonName: 'Sign In',
                  onTap: () {
                    timer = Timer(Duration(seconds: 4), () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => UserHomePage(),
                        ),
                      );
                    });

                    this.scaffoldKey.currentState.showSnackBar(new SnackBar(
                          duration: new Duration(seconds: 3),
                          content: new Row(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Signing-In...")
                            ],
                          ),
                        ));
                  },
                  bgColor: Colors.white,
                  textColor: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
