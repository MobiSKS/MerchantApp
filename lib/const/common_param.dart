import 'package:flutter/material.dart';
import 'dart:ui';
import '../util/utils.dart';
import 'url_constant.dart';

Map<String, String> commonHeader = {
  "Authorization": Utils.userToken,
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


