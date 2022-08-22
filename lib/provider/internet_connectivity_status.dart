

import 'package:flutter/cupertino.dart';

class InternetConnectivityStatus with ChangeNotifier{
  bool? isInternet;

  setStatus(bool isInternet){
    this.isInternet=isInternet;
    notifyListeners();
  }
}