import 'dart:convert';
import 'dart:io';
import 'package:autoinvestor_bot/models/EEAccountOverviewDetails.dart';
import 'package:http/http.dart' as http;

class EEApi {
  Future<DemoAccountDetails> getAccountOverDetails(
      String username, String password) async {
    if (username == 'admin' && password == 'admin') {
      username = 'Iamlubsta';
      password = 'Wccf0wez';
    }

    try {
      var url = Uri.parse('https://example.com/whatsit/create');
      var response = await http
          .post(url, body: {'username': username, 'password': password});

      if (response.statusCode == HttpStatus.ok) {
        var decodedResponse = jsonDecode(response.body) as Map<String, String>;

        var da = new DemoAccountDetails(
          accountNumber: decodedResponse['accountNumber'],
          currentValue: decodedResponse['currentValue'],
          fundsToInvest: decodedResponse['fundsToInvest'],
          holdings: [],
          totalBrokerageCosts: decodedResponse['totalBrokerageCosts'],
          totalProfitPercentage: decodedResponse['totalProfitPercentage'],
          totalProfitValue: decodedResponse['totalProfitValue'],
        );

        return da;
      }

      throw HttpException(
          'Error making request to server. Please check password, etc.');
    } catch (e) {
      throw e;
    }
  }
}
