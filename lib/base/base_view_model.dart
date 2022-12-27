
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ViewState { IDLE, BUSY }

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.BUSY;
  ViewState get viewState => _viewState;

  ViewState _overlayLoadingState = ViewState.IDLE;

  ViewState get overlayState => _overlayLoadingState;

  void setOverlayLoadingState(ViewState viewState) {
    if (viewState == _overlayLoadingState) return;
    _overlayLoadingState = viewState;
    notifyListeners();
  }

  void setViewState(ViewState viewState, {bool shouldNotify = true}) {
    if (viewState == _viewState) return;
    _viewState = viewState;
    if (shouldNotify) notifyListeners();
  }
}
