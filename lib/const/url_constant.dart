class UrlConstant {
  static const String baseUrl = "https://dtpapi.mloyalretail.com/api/dtplus/";
  static const String loginApi =
      "merchant/get_merchant_registration_parameters";
  static const String sendOTPApi = "RBE/rbe_sent_otp_forgot_password";
  static const String getProduct = "settings/get_product";
  static const String generateOtpForSale = "transaction/generate_otp";
  static const String saleByTerminal = "transaction/sale_by_terminal";
  static const String generateQR = "Mobile/generate_QR_code";
  static const String otpForFastTag = "Fastag/fastag_get_otp";
  static const String cardFeePayment = "transaction/card_fee_payment";
  static const String confirmFastTagOtp = "Fastag/fastag_confirm_otp";
  static const String creditSaleOutstandingDetail ="dealercredit/get_credit_sale_outstanding_details";

//==============================api_key && secret_key=================================

  static const String apiKey = "3C25F265-F86D-419D-9A04-EA74A503C197";
  static const String secretKey = "PVmMSclp834KBIUa9O-XxpBsDJhsi1dsds74CiGaoo5";
}
