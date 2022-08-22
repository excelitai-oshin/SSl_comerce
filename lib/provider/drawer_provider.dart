
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DrawerProvider with ChangeNotifier{

  bool switchValue = false;
  setSwitchValue(bool value){
    switchValue=value;
    notifyListeners();
  }

}