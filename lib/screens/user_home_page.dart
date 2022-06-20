import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:autoinvestor_bot/screens/user/api_binding_page.dart';
import 'package:autoinvestor_bot/screens/user/portfolio_page.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../widgets/widget.dart';
import '../apis/EEApi.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool isPasswordVisible = true;
  int currentIndex = 4;
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
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        //to make page scrollable
        child: this._buildBody(),
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        onTap: (int index) {
          if (index == 0 || index == 2 || index == 3) {
            this.scaffoldKey.currentState.showSnackBar(new SnackBar(
                  duration: Duration(seconds: 1),
                  content: Row(
                    children: <Widget>[new Text("Work in progress...")],
                  ),
                ));
          } else {
            setState(() {
              this.currentIndex = index;
            });
          }
        },
        currentIndex: this.currentIndex,
        items: [
          FloatingNavbarItem(icon: Icons.currency_exchange, title: 'Trade'),
          FloatingNavbarItem(icon: Icons.podcasts, title: 'Portfolio'),
          FloatingNavbarItem(icon: Icons.search, title: 'Search'),
          FloatingNavbarItem(icon: Icons.newspaper, title: 'News'),
          FloatingNavbarItem(
            icon: Icons.api,
            title: 'API Binding',
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (this.currentIndex) {
      case 1:
        return PortfolioPage();
      case 4:
        return ApiBindingPage();
    }
  }
}
