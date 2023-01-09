class UrlConstant {
  static const String baseUrl =
      "http://dtpapi.mloyalcapture.com/api/dtplus/"; // UAT url
  //  "https://dtpapi.mloyalretail.com/api/dtplus/";  //Dev url
  static const String hpPayLink = "https://www.hppay.in";
  static const String loginApi =
      "merchant/get_merchant_registration_parameters";
  static const String sendOTPApi = "RBE/rbe_sent_otp_forgot_password";
  static const String getProduct = "settings/get_product";
  static const String generateOtpForSale = "transaction/generate_otp";
  static const String saleByTerminal = "transaction/sale_by_terminal";
  static const String generateQR = "Mobile/generate_QR_code";
  static const String otpForFastTag = "Fastag/fastag_get_otp";
  static const String cardFeePayment =
      "transaction/get_card_fee_amount_with_form_number";
  static const String confirmFastTagOtp = "Fastag/fastag_confirm_otp";
  static const String creditSaleOutstandingDetail =
      "dealercredit/get_credit_sale_outstanding_details";
  static const String transactionSummary = "customer/get_transactions_summary";
  static const String transactionType = "settings/get_transaction_type";
  static const String transactionDetail =
      "merchant/merchant_transaction_detail";
  static const String cardbalance = "transaction/balance_enquiry";
  static const String receivablePayable =
      "merchant/merchant_receivable_payable_detail";
  static const String changePasswordVerifyOTP = "settings/change_password";
  static const String changePasswordOTP = "settings/change_password_otp_sent";
  // static const String settlementApi =
  //     "merchant/merchant_erp_reload_sale_earning_detail";
  static const String settlementlistApi =
      "merchant/get_merchant_settlement_details";
  static const String paymentListApi = "merchant/get_merchnat_payment_details";
  static const String batchDetailApi = "merchant/merchant_batch_detail";
  static const String forgetPassOTP = "settings/forgot_password_sent_otp";
  static const String forgetPassOTPVerify = "settings/forgot_password";
  static const String getQRStatus = "Mobile/get_QR_code_payment_status";
  static const String transationSlip = "merchant/get_merchant_transaction_slip";
  static const String duplicateTransactionDetail =
      "transaction/get_duplicate_transaction";
  static const String cardFeeAmount = "transaction/card_fee_payment";
  static const String acknowledgementApi = "transaction/check_update_acknowledgement_status";

//==============================api_key && secret_key=================================
  static const String apiKey = "3C25F265-F86D-419D-9A04-EA74A503C197";
  static const String secretKey = "PVmMSclp834KBIUa9O-XxpBsDJhsi1dsds74CiGaoo5";
}
