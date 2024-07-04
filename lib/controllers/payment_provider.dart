import 'package:flutter/material.dart';

class PaymentNotifier extends ChangeNotifier {
  String? _paymentUrl;

  String get paymentUrl => _paymentUrl ?? '';

  set paymentUrl(String newValue) {
    _paymentUrl = newValue;
    notifyListeners();
  }
}
