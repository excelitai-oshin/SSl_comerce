
import 'package:flutter/material.dart';
import 'package:ssl_comerce/service/local_storage.dart';
import 'package:ssl_comerce/service/sslcommerz.dart';
import 'package:ssl_comerce/view/log_in_screen.dart';

import '../main.dart';
import '../model/bank_receipt/bank_receipt_model.dart';
import '../service/db_service.dart';
import 'component/app_style.dart';

class ReceiptDetailsPage extends StatefulWidget {
  ReceiptDetailsPage({
    Key? key, String? receiptId, String? date, String? memberId, String? memberName, String? month, String? startDate, String? finishDate, String? amount, String? action,
  }) : super(key: key);


  @override
  _ReceiptDetailsPageState createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Receipt Details"),
        actions: [
          IconButton(onPressed: ()async{
            await LocalStorageStore().userDeleteToken();
            memberId=null;
            receiptNumber=null;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
                    (route) => false);

          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: FutureBuilder(
        future: DBService().getBankReceiptDetails(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<Data> receiptDetails=snapshot.data as List<Data>;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.5,
              color: Color(0xfffcf8e3),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Member Name")),
                        Expanded(child: Text(receiptDetails[0].memberName.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Receipt Number")),
                        Expanded(child: Text(receiptDetails[0].receiptNumber.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Receipt Date")),
                        Expanded(child: Text(receiptDetails[0].receiptDate.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Start Date")),
                        Expanded(child: Text(receiptDetails[0].startDate.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Finish Date")),
                        Expanded(child: Text(receiptDetails[0].finishDate.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Month Period")),
                        Expanded(child: Text(receiptDetails[0].monthPeriod.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Total Amount")),
                        Expanded(child: Text(receiptDetails[0].totalAmount.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Status")),
                        Expanded(child: Text(receiptDetails[0].status.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Member Id")),
                        Expanded(child: Text(receiptDetails[0].memberId.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Membership Number")),
                        Expanded(child: Text(receiptDetails[0].membershipNumber.toString())),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text("Member Mobile Number")),
                        Expanded(child: Text(receiptDetails[0].memberMobileNumber.toString())),
                      ],
                    ),
                  ],
                ),
              ),

            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: secondaryColor,
                ),
                  onPressed: () {
                    //DBService().getReceipt(context);
                    SslCommerzService().sSLCommerzInitialization(context,receiptDetails[0].totalAmount.toString(),receiptDetails[0].receiptNumber!+receiptDetails[0].memberId!);
                  },
                  child: Text("Pay Now")),
            ),
          ],
        );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
