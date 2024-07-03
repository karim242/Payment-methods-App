import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_part/Features/checkout/data/models/payment_initent_models/payment_initent_models.dart';
import 'package:payment_part/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_part/core/utils/api_keys.dart';
import 'package:payment_part/core/utils/api_service.dart';

class StripeService {
  ///1 -createPaymentIntent

  final ApiService apiService = ApiService();
  Future<PaymentInitentModels> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiService.post(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentIntentInputModel.tojson(),
      token: ApiKeys.secretKey,
    );

    var paymentInitentModel = PaymentInitentModels.fromJson(response.data);
    return paymentInitentModel;
  }

////2- initPaymentSheet

  Future initPaymentSheet({required String paymentIntentClientSecret}) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
      // Main params
      merchantDisplayName: 'karim',
      paymentIntentClientSecret: paymentIntentClientSecret,
    ));
  }

  ///3- PaymentSheet Present

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  ///4 - make payment operation
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentInitentModel =
        await createPaymentIntent(paymentIntentInputModel);
    await initPaymentSheet(
        paymentIntentClientSecret: paymentInitentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
