import '../util/utils.dart';
import 'url_constant.dart';

Map<String, String> commonHeader = {
  "API_Key": UrlConstant.apiKey,
  "Secret_Key": UrlConstant.secretKey,
  "Content-Type": "application/json",
};

Map commonReqBody = {
  "Useragent": Utils.checkOs(),
  "UserId": Utils.merchantId,
  "Merchantid": Utils.merchantId,
  "Terminalid": Utils.terminalId,
};
const String rupeeSign = "₹";


