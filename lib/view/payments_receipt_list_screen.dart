
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ssl_comerce/service/db_service.dart';
import '../model/bank_receipt/bank_receipt_model.dart';
import '../service/local_storage.dart';
import 'about_page.dart';
import 'component/app_style.dart';
import 'drawer/nav_drawer.dart';
import 'log_in_screen.dart';
import 'notification.dart';
import 'profile_Screen.dart';

class PaymentReceiptListScreen extends StatefulWidget {
  const PaymentReceiptListScreen({Key? key}) : super(key: key);

  @override
  State<PaymentReceiptListScreen> createState() => _PaymentReceiptListScreenState();
}

class _PaymentReceiptListScreenState extends State<PaymentReceiptListScreen> {
  int currentIndex = -1;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor, //Colors.purple,
        centerTitle: true,
        title: Text("Payments Receipt List"),
        actions: [
          IconButton(onPressed: ()async{
            await LocalStorageStore().userDeleteToken();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LogInScreen()),
                    (route) => false);

    }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: NavigationDrawer(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            FutureBuilder(
              future: DBService().getBankReceiptDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data> payment = snapshot.data as List<Data>;
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          showBottomBorder: true,
                          dividerThickness: 1,
                          columnSpacing: 50,
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Colors.amber;
                            // Theme.of(context)
                            //   .colorScheme
                            //   .primary
                            //   .withOpacity(0.08);
                            return null; // Use the default value.
                          }),
                          dataRowColor: MaterialStateProperty.resolveWith(
                              _getDataRowColor),
                          columns: [
                            DataColumn(
                                label: Text(
                              'SL.',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Receipt ID',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Date',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Member ID',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Member Name',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Month',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Start Date',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Finish Date',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Amount',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            )),
                            DataColumn(
                                label: Text(
                              'Action',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ))
                          ],
                          rows: [
                            DataRow(
                                onLongPress: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder:
                                  //             (context) =>
                                  //                 ReceiptDetailsPage(
                                  //                     receiptId: payment[0]
                                  //                         .id
                                  //                         .toString(),
                                  //                     date: payment[0]
                                  //                         .receiptDate
                                  //                         .toString(),
                                  //                     memberId: payment[0]
                                  //                         .memberName
                                  //                         .toString(),
                                  //                     month: payment[0]
                                  //                         .monthPeriod
                                  //                         .toString(),
                                  //                     startDate: payment[0]
                                  //                         .startDate
                                  //                         .toString(),
                                  //                     finishDate: payment[0]
                                  //                         .finishDate
                                  //                         .toString(),
                                  //                     amount: payment[0]
                                  //                         .totalAmount
                                  //                         .toString(),
                                  //                     action: payment[0]
                                  //                         .status
                                  //                         .toString())));
                                },
                                cells: [
                                  DataCell(
                                      GestureDetector(
                                    onTap: () {
                                      customNavidation(
                                          context: context,
                                          receiptId: payment[0].id.toString(),
                                          date:
                                              payment[0].receiptDate.toString(),
                                          memberId:
                                              payment[0].memberName.toString(),
                                          month:
                                              payment[0].memberName.toString(),
                                          startDate:
                                              payment[0].startDate.toString(),
                                          finishDate:
                                              payment[0].finishDate.toString(),
                                          amount:
                                              payment[0].totalAmount.toString(),
                                          action: payment[0].status.toString());
                                    },
                                    child: Text(
                                      payment[0].id.toString(),
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0].receiptNumber.toString(),
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0]
                                          .receiptDate
                                          .toString(), //'Zisan'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0].memberId.toString(),
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0].memberName.toString(), //'16'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0]
                                          .monthPeriod
                                          .toString(), //'Zisan'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0].startDate.toString(), //'Zisan'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0]
                                          .finishDate
                                          .toString(), //'Zisan'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0]
                                          .totalAmount
                                          .toString(), //'Zisan'
                                    ),
                                  )),
                                  DataCell(GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      payment[0].status.toString(), //'16'
                                    ),
                                  )),
                                ]),
                          ]),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: currentIndex == -1 ? primaryColor : secondaryColor,
        onPressed: () {
          setState(() {
            currentIndex = -1;
          });
        },
        child: const Icon(FontAwesomeIcons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...MainMenuModel.list.map(
              (MainMenuModel data) {
                return data.isBlank
                    ? const SizedBox(
                        width: 10,
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = data.index;
                            if(currentIndex==0){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentReceiptListScreen()));
                            }
                            if(currentIndex==1){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Notification_Screen()));
                            }
                            if(currentIndex==2){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
                            }
                            if(currentIndex==3){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage()));
                            }
                          });
                          // ignore: avoid_print
                          print(data.index.toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //SizedBox(height: 10,),
                              Icon(
                                data.icon,
                                color: currentIndex == data.index
                                    ? primaryColor
                                    : secondaryColor,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                data.label!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: currentIndex == data.index
                                            ? primaryColor
                                            : secondaryColor),
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  customNavidation(
      {BuildContext? context,
      String? receiptId,
      String? date,
      String? memberId,
      String? memberName,
      String? month,
      String? startDate,
      String? finishDate,
      String? amount,
      String? action}) {
    // Navigator.push(
    //     context!,
    //     MaterialPageRoute(
    //         builder: (context) => ReceiptDetailsPage(
    //               receiptId: receiptId,
    //               date: date,
    //               memberId: memberId,
    //               memberName: memberName,
    //               month: month,
    //               startDate: startDate,
    //               finishDate: finishDate,
    //               amount: amount,
    //               action: action,
    //             )));
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Color(0xfffcf8e3);
  }

  _getBody() {
    switch (currentIndex) {
      case 0:
        return PaymentReceiptListScreen();
      case 1:
        return Container();
      case 2:
        return ProfilePage();
      case 3:
        return AboutPage();
      default:
        return _buildHompageBody;
    }
  }


  Widget _buildHompageBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          FutureBuilder(
            future: DBService().getBankReceiptDetails(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                List<Data> payment = snapshot.data as List<Data>;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: SingleChildScrollView(
                    child: DataTable(
                        showBottomBorder: true,
                        dividerThickness: 1,
                        columnSpacing: 1,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Receipt Number',
                            style: TextStyle(
                                //fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          )),
                          DataColumn(
                              label: Text(
                            'Receipt Date',
                            style: TextStyle(
                                //fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          )),
                          DataColumn(
                              label: Text(
                            'totalAmount',
                            style: TextStyle(
                                //fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          )),
                          DataColumn(
                            label: Text(
                              'status',
                              style: TextStyle(
                                  //fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black),
                            ),
                          )
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text(
                              payment[0].id.toString(),
                            )),
                            DataCell(Text(
                              payment[0].receiptDate.toString(), //'Zisan'
                            )),
                            DataCell(Text(
                              payment[0].totalAmount.toString(), //'16'
                            )),
                            DataCell(Text(
                              payment[0].status.toString(), //'16'
                            )),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(
                              payment[0].id.toString(),
                            )),
                            DataCell(Text(
                              payment[0].receiptDate.toString(), //'Zisan'
                            )),
                            DataCell(Text(
                              payment[0].totalAmount.toString(), //'16'
                            )),
                            DataCell(Text(
                              payment[0].status.toString(), //'16'
                            )),
                          ]),
                        ]),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}

class MainMenuModel {
  late final int index;
  late final IconData? icon;
  late final String? label;
  late final bool isBlank;
  MainMenuModel(
      {required this.index, this.label, this.icon, this.isBlank = false});

  static List<MainMenuModel> list = [
    MainMenuModel(
      index: 0,
      label: 'Home',
      icon: FontAwesomeIcons.home,
    ),
    MainMenuModel(
      index: 1,
      label: 'Notification',
      icon: FontAwesomeIcons.bell,
    ),
    MainMenuModel(
      index: -1,
      isBlank: true,
    ),
    MainMenuModel(
      index: 2,
      label: 'Profile',
      icon: FontAwesomeIcons.userAlt,
    ),
    MainMenuModel(
      index: 3,
      label: 'About',
      icon: FontAwesomeIcons.indent,
    ),
  ];
}
