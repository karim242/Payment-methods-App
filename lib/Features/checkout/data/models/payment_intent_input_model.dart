class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String cusomerId;

  PaymentIntentInputModel({
    required this.amount, required this.currency, required this.cusomerId});

    tojson() {
      return {
        'amount': '${amount}00',
        'currency': currency,
        'cusomerId': cusomerId
      };
    }
}