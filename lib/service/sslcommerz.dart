import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SslCommerzService {
  sSLCommerzInitialization(BuildContext context, String amount,String custom_transaction_id) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
          //ipn_url: "https://beta-dtba.btla.net/dashboard",
          //multi_card_name: "bkash",
          currency: SSLCurrencyType.BDT,
          product_category: "Food",
          sdkType: SSLCSdkType.TESTBOX,
          store_id:
              "dtbab6224f97017631", //"rahim62e2bf44c437c",//"demotest",//"demotest",//"dtbab6224f97017631",
          store_passwd:
              "dtbab6224f97017631@ssl", //"rahim62e2bf44c437c@ssl",//"qwerty",//"qwtrty",//"dtbab6224f97017631@ssl",
          total_amount: double.parse(amount),
          tran_id: "custom_transaction_id"+custom_transaction_id.toString(),//"custom_transaction_id:000123"),
    )
    );
    var result = await sslcommerz.payNow();
    if (result is PlatformException) {
      // print("the response is: " +
      //     result.message.toString() +
      //     " code: " +
      //     result.code);
    } else {
      SSLCTransactionInfoModel model = result;
      // FToast().showToast(
      //   child: Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(25.0),
      //       color: Colors.greenAccent,
      //     ),
      //     child: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         Icon(Icons.check),
      //         SizedBox(
      //           width: 12.0,
      //         ),
      //         Text("Transaction successful: Amount ${model.amount} TK"),
      //       ],
      //     ),
      //   ),
      //     toastDuration: Duration(seconds: 8),
      //     positionedToastBuilder: (context, child) {
      //       return Positioned(
      //         child: child,
      //         top: 16.0,
      //         left: 16.0,
      //       );
      //     }
      // );
      Fluttertoast.showToast(
          msg: "Transaction successful: Amount ${model.amount} TK",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
      );
    }
  }
}
