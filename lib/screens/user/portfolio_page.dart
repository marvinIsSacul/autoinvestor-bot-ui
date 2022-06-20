import 'dart:async';

import 'package:autoinvestor_bot/screens/user_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../../constants.dart';
import '../../models/EEAccountOverviewDetails.dart';
import '../../screens/screen.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../widgets/widget.dart';
import '../../apis/EEApi.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  String loadedUsername = "";
  Timer timer;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final storage = new LocalStorage('data.binding');
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();

  @override
  void initState() {
    super.initState();

    this.setState(() {
      loadedUsername = storage.getItem("username");
    });
  }

  @override
  Widget build(BuildContext context) {
    return this._buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final makeListTile = (Holding holding) {
      return ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            holding.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // isThreeLine: true,
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale,
                  color: holding.profitOrLoss.contains('-')
                      ? Colors.redAccent
                      : Colors.greenAccent),
              Text(" " + holding.currentPrice,
                  style: TextStyle(color: Colors.white)),
              Text(", " + holding.profitOrLoss.replaceAll(RegExp('\n'), ' '),
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0));
    };

    final makeCard = (Holding holding) {
      return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: makeListTile(holding),
        ),
      );
    };

    final holdings = [
      Holding(
          name: 'African Rainbow Capital Investments Limited',
          purchaseValue: 'R 2 000.00',
          currentPrice: 'R 6.21',
          currentValue: 'R 1 884.67',
          profitOrLoss: '- R 115.33\n(- 5.77%)'),
      Holding(
          name: 'Capitec Bank Holdings Limited',
          purchaseValue: 'R 2 100.00',
          currentPrice: 'R 2 075.00',
          currentValue: 'R 2 075.00',
          profitOrLoss: '- R 25.00\n(- 1.19%)'),
      Holding(
          name: 'Shoprite Holdings Limited',
          purchaseValue: 'R 300.00',
          currentPrice: 'R 211.19',
          currentValue: 'R 267.87',
          profitOrLoss: '- R 32.13\n(- 10.71%)')
    ];

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: holdings.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(holdings[index]);
        },
      ),
    );

    return Container(
      child: makeBody,
    );
  }

  Widget renderApiNotFound() {
    return Text(
      'API Not Bound. Please bind API first.',
      style: kBodyText,
    );
  }
}
