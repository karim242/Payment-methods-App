import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_part/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_part/Features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;

  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    final result = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    result.fold((failure) {
      emit(PaymentFailure(errMessage: failure.errMessage));
    }, (r) {
      emit(PaymentSuccess());
    });
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
