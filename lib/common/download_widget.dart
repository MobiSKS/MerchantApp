// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dtplusmerchant/util/uiutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
                  
Future<void> captureAndSharePng(BuildContext context, GlobalKey key,
    {bool pop = true,
    String message = "Receipt Downloaded Successfully"}) async {
  await downloadScreenshot(key);

  if (pop) {
    alertPopUp(context, message);
  } else {
  alertPopUp(context, message);
  }
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> downloadScreenshot(GlobalKey<State<StatefulWidget>> key) async {
  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image image = await boundary.toImage();
  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  String dir = (await getApplicationDocumentsDirectory()).path;
  String fullPath = '$dir/abc.png';
  log("local file full path $fullPath");
  File file = File(fullPath);
  await file.writeAsBytes(pngBytes);

  final result = await ImageGallerySaver.saveImage(pngBytes);
  log(result.toString());
 

  log("File Saved to Gallery");
}
