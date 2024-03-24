enum PaymentType {
  credit_card,
  qr_code,
  cash;

  String get title {
    switch (this) {
      case PaymentType.credit_card:
        return "Credit/Debit Card";
      case PaymentType.qr_code:
        return "QR Code";
      case PaymentType.cash:
        return "Pay in cash";
    }
  }
  String get payLoadParameter {
    switch (this) {
      case PaymentType.credit_card:
        return "credit-card";
      case PaymentType.qr_code:
        return "qr-code";
      case PaymentType.cash:
        return "cash";
    }
  }
}