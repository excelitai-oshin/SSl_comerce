
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ssl_comerce/provider/internet_connectivity_status.dart';
import 'package:ssl_comerce/view/about_page.dart';
import 'package:ssl_comerce/view/detail_receipt_page.dart';
import 'package:ssl_comerce/view/home_screen.dart';
import 'package:ssl_comerce/view/log_in_screen.dart';
import 'package:ssl_comerce/view/notification.dart';
import 'package:ssl_comerce/view/profile_Screen.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../main.dart';
import '../member_receiptDetails.dart';
import '../model/receipt_list_model.dart';
import '../service/customFunc.dart';
import '../service/db_service.dart';
import '../service/local_storage.dart';
import 'component/app_style.dart';

class ReceiptListOfAMemberScreen extends StatefulWidget {
  const ReceiptListOfAMemberScreen({Key? key}) : super(key: key);

  @override
  State<ReceiptListOfAMemberScreen> createState() =>
      _ReceiptListOfAMemberScreenState();
}

class _ReceiptListOfAMemberScreenState extends State<ReceiptListOfAMemberScreen> {
  //RefreshController _refreshController= RefreshController();
  int currentIndex = -1;
  late _JsonDataGridSource jsonDataGridSource;
  List<DataList> receiptList = [];


  List<GridColumn> getColumns(Size size) {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        columnName: 'id',
        width: size.width * .15,
        label: Container(
          color: Colors.orangeAccent.shade100,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'SL No',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'receipt_number',
        width: size.width * .25,
        label: Container(
          color: Colors.amber.shade100,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Receipt No',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'receipt_date',
        width: size.width * .25,
        label: Container(
          color: Colors.greenAccent.shade100,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Receipt Date',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'total_amount',
        width: size.width * .3,
        label: Container(
          color: Colors.blueAccent.shade100,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Total Amount',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'status',
        width: size.width * .2,
        label: Container(
          color: Colors.lightGreen.shade100,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Status'),
        ),
      )
    ]);
    return columns;
  }

  loadList() async {
    final internetConnectivityStatus =
        Provider.of<InternetConnectivityStatus>(context);
    internetConnectivityStatus.isInternet!
        ? receiptList = await DBService().getMemberReceiptList()
        : Fluttertoast.showToast(
            msg: "Please Check Your Internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.orangeAccent,
            textColor: Colors.white,
            fontSize: 16.0,
          );
  }

  Future<void> _pullRefresh() async {
    //List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
      //numbersList = freshNumbers;
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }


  @override
  Widget build(BuildContext context) {
    final internetConnectivityStatus =
    Provider.of<InternetConnectivityStatus>(context);
    return Scaffold(
      //backgroundColor: C,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text("Receipt list"),
        actions: [
          IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      title: Center(
                          child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/logout.png"))),
                      content: Text("Are you sure you want to Log Out"),
                      actions: [
                        TextButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await LocalStorageStore().userDeleteToken();
                            memberId = null;
                            receiptNumber = null;
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()),
                                (route) => false);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      //drawer: NavigationDrawer(),
      body:
      internetConnectivityStatus.isInternet!
          ? Container(
        //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: AppBar(
                  backgroundColor: secondaryColor,
                  leading: SizedBox(),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        icon: Icon(Icons.receipt_long_outlined),
                        text: "All List",
                      ),
                      Tab(
                        icon: Icon(
                          Icons.download_done_sharp,
                        ),
                        text: "Paid List",
                      ),
                      Tab(
                        icon: Icon(
                          Icons.pending_actions_outlined,
                        ),
                        text: "UnPaid List",
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: FutureBuilder(
                          future: DBService()
                              .getMemberReceiptList(), //generateProductList(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              receiptList = snapshot.data;
                              jsonDataGridSource =
                                  _JsonDataGridSource(receiptList, context);
                              return SfDataGrid(
                                horizontalScrollPhysics: ScrollPhysics(),
                                isScrollbarAlwaysShown: true,
                                source: jsonDataGridSource,
                                columns:
                                getColumns(MediaQuery.of(context).size),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              );
                            }
                          }),
                    ),
                    FutureBuilder(
                        future: DBService()
                            .getMemberReceiptList(), //generateProductList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            receiptList = snapshot.data;
                            jsonDataGridSource =
                                _JsonDataGridSource(receiptList, context);
                            return SfDataGrid(
                              source: jsonDataGridSource,
                              columns:
                              getColumns(MediaQuery.of(context).size),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            );
                          }
                        }),
                    FutureBuilder(
                        future: DBService()
                            .getMemberReceiptList(), //generateProductList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            receiptList = snapshot.data;
                            jsonDataGridSource =
                                _JsonDataGridSource(receiptList, context);
                            return SfDataGrid(
                              source: jsonDataGridSource,
                              columns:
                              getColumns(MediaQuery.of(context).size),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),

      )
          : Center(
        child: Text("Please Check your internet"),
      ),
      //_buildBody(internetConnectivityStatus),
//       SmartRefresher(
//         enablePullDown: true,
//         header: WaterDropHeader(
//           waterDropColor: Colors.teal,
// // complete: If the refresh is completed show this else failed
//           complete: Text('Complete',
//               style: TextStyle(
//                   color: Colors.teal,
//                   fontSize: 18,
//                   fontWeight: FontWeight
//                       .bold)), // you can customize this whatever you like
//           failed:
//               Text('Failed', style: TextStyle(color: Colors.red, fontSize: 18)),
//         ),
//         controller: _refreshController,
//         onRefresh: _onRefresh,
//         onLoading: _onLoading,
//         child: ReceiptListOfAMemberScreen()//_buildBody(),
//       ),
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
                            if (currentIndex == 0) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                  (route) => false);
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            }
                            if (currentIndex == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Notification_Screen()));
                            }
                            if (currentIndex == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            }
                            if (currentIndex == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutPage()));
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

  Widget _buildBody(InternetConnectivityStatus internetConnectivityStatus) {
    return internetConnectivityStatus.isInternet!
        ? Container(
                //padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: AppBar(
                      backgroundColor: secondaryColor,
                      leading: SizedBox(),
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            icon: Icon(Icons.receipt_long_outlined),
                            text: "All List",
                          ),
                          Tab(
                            icon: Icon(
                              Icons.download_done_sharp,
                            ),
                            text: "Paid List",
                          ),
                          Tab(
                            icon: Icon(
                              Icons.pending_actions_outlined,
                            ),
                            text: "UnPaid List",
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: FutureBuilder(
                              future: DBService()
                                  .getMemberReceiptList(), //generateProductList(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  receiptList = snapshot.data;
                                  jsonDataGridSource =
                                      _JsonDataGridSource(receiptList, context);
                                  return SfDataGrid(
                                    horizontalScrollPhysics: ScrollPhysics(),
                                    isScrollbarAlwaysShown: true,
                                    source: jsonDataGridSource,
                                    columns:
                                        getColumns(MediaQuery.of(context).size),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                    ),
                                  );
                                }
                              }),
                        ),
                        FutureBuilder(
                            future: DBService()
                                .getMemberReceiptList(), //generateProductList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                receiptList = snapshot.data;
                                jsonDataGridSource =
                                    _JsonDataGridSource(receiptList, context);
                                return SfDataGrid(
                                  source: jsonDataGridSource,
                                  columns:
                                      getColumns(MediaQuery.of(context).size),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                );
                              }
                            }),
                        FutureBuilder(
                            future: DBService()
                                .getMemberReceiptList(), //generateProductList(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                receiptList = snapshot.data;
                                jsonDataGridSource =
                                    _JsonDataGridSource(receiptList, context);
                                return SfDataGrid(
                                  source: jsonDataGridSource,
                                  columns:
                                      getColumns(MediaQuery.of(context).size),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                );
                              }
                            }
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

    )
        : Center(
            child: Text("Please Check your internet"),
          );
  }
}

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.receiptList, this.context) {
    buildDataGridRow();
  }
  BuildContext? context;
  List<DataGridRow> dataGridRows = [];
  //List<_Product> productlist = [];
  List<DataList> receiptList = [];
  int id = 0;
  int index = 0;

  void buildDataGridRow() {
    dataGridRows = receiptList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'id', value: ++id),
        DataGridCell<String>(
            columnName: 'receipt_number', value: dataGridRow.receiptNumber),
        DataGridCell<String>(
            columnName: 'receipt_date', value: dataGridRow.receiptDate),
        DataGridCell<String>(
            columnName: 'total_amount', value: dataGridRow.totalAmount),
        // DataGridCell<DateTime>(
        //     columnName: 'status', value: dataGridRow.orderDate),
        DataGridCell<String>(columnName: 'status', value: dataGridRow.status),
      ]);
    }).toList(growable: false);
  }

  goToDetailPage(String index, BuildContext context) {
    receiptNumber = receiptList[int.parse(index) - 1].receiptNumber;
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ReceiptDetailsPage()));
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      GestureDetector(
        onTap: () {
          goToDetailPage(row.getCells()[0].value.toString(), context!);
        },
        child: Container(
          color: Colors.orangeAccent.shade100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          goToDetailPage(row.getCells()[0].value.toString(), context!);
        },
        child: Container(
          color: Colors.amber.shade100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[1].value,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          goToDetailPage(row.getCells()[0].value.toString(), context!);
        },
        child: Container(
          color: Colors.greenAccent.shade100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          goToDetailPage(row.getCells()[0].value.toString(), context!);
        },
        child: Container(
          color: Colors.blueAccent.shade100,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[3].value,
            //DateFormat('MM/dd/yyyy').format(row.getCells()[3].value).toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          goToDetailPage(row.getCells()[0].value.toString(), context!);
        },
        child: Container(
          color: Colors.lightGreen.shade100,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(8.0),
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: row.getCells()[4].value.toString() == "UNPAID"
                    ? Colors.red
                    : Colors.black),
          ),
        ),
      ),
    ]);
  }
}
