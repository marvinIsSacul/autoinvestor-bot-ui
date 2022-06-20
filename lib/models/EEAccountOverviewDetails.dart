class Holding {
  String name;
  String purchaseValue;
  String currentValue;
  String currentPrice;
  String profitOrLoss;

  Holding({
    this.name,
    this.purchaseValue,
    this.currentValue,
    this.currentPrice,
    this.profitOrLoss,
  });
}

class DemoAccountDetails {
  String accountNumber;
  String currentValue;
  String totalProfitValue;
  String totalProfitPercentage;
  String fundsToInvest;
  String totalBrokerageCosts;

  List<Holding> holdings;

  DemoAccountDetails({
    this.accountNumber,
    this.currentValue,
    this.totalProfitValue,
    this.fundsToInvest,
    this.totalBrokerageCosts,
    this.totalProfitPercentage,
    this.holdings,
  });
}
