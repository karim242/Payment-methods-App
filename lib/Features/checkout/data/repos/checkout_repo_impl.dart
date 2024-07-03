import 'package:dartz/dartz.dart';
import 'package:payment_part/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_part/Features/checkout/data/repos/checkout_repo.dart';
import 'package:payment_part/core/errors/failures.dart';
import 'package:payment_part/core/utils/stripe_service.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({required PaymentIntentInputModel paymentIntentInputModel})async {
    try {
  await stripeService.makePayment(paymentIntentInputModel: paymentIntentInputModel);

  return const Right(null);
}  catch (e) {

  return Left(ServerFailure(errMessage: e.toString()));
}
  }
}