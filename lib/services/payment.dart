
class StripeTransactionResponse{
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService{
  static String apiBase="https://api.stripe.com/v1";
  static String paymentApiUrl="${StripeService.apiBase}/payment_intents";
  static String secret="";
}



