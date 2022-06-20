import 'dart:async';

import 'package:autoinvestor_bot/screens/user_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../../constants.dart';
import '../../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../widgets/widget.dart';
import '../../apis/EEApi.dart';

class ApiBindingPage extends StatefulWidget {
  @override
  _ApiBindingPageState createState() => _ApiBindingPageState();
}

class _ApiBindingPageState extends State<ApiBindingPage> {
  bool isPasswordVisible = true;
  Timer timer;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final storage = new LocalStorage('data.binding');
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    this.txtUsername.text = this.storage.getItem("username") ?? '';
    this.txtPassword.text = this.storage.getItem("password") ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return this._buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
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
                        "Precautions",
                        style: kBodyText2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '1. Please confirm that the API permission has checked "Enabled spot & Margin Trading"',
                        style: kBodyText,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      MyTextField(
                        hintText: 'Username',
                        inputType: TextInputType.text,
                        textInputController: this.txtUsername,
                      ),
                      MyPasswordField(
                        isPasswordVisible: isPasswordVisible,
                        textEditingController: this.txtPassword,
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextButton(
                  buttonName: 'Bind',
                  onTap: () {
                    final username = this.txtUsername.text;
                    final password = this.txtPassword.text;

                    if (username.isEmpty || password.isEmpty) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(milliseconds: 500),
                        content: Row(
                          children: <Widget>[
                            Text("Invalid username and/or password...")
                          ],
                        ),
                      ));
                      return;
                    }

                    this.setState(() {
                      this.storage.setItem("username", username).then((value) =>
                          this.storage.setItem("password", password));

                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Row(
                          children: <Widget>[
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Binding...")
                          ],
                        ),
                      ));
                    });
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
