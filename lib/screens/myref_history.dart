import 'dart:convert';
import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/services/http.service.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class MyReferrals extends StatefulWidget {
  const MyReferrals({Key? key}) : super(key: key);

  @override
  State<MyReferrals> createState() => _MyReferralsState();
}

class _MyReferralsState extends State<MyReferrals> {
  List? tableDatas;

  getData() async {
    String username = await LocalStorage().getString("username");
    final table = await HttpService.post(Api.myRef, {"username": username});
    tableDatas = jsonDecode(table.data);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 50,
            centerTitle: true,
            backgroundColor: Color(0xff227324),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
            title: CustomText(
              text: "My Referrals",
              size: 16,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          body: /*tableDatas == null ?  Center(child: SpinKitDualRing(color: appColor))
            : */
              Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
              columnSpacing: 8,
              horizontalMargin: 8,
              minWidth: 600,
              smRatio: 0.5, //changed
              lmRatio: 1.2, //default
              headingTextStyle: TextStyle(color: Colors.white),
              headingRowColor: MaterialStateProperty.all(appColor),
              columns: [
                DataColumn2(
                  label: Text('No',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  size: ColumnSize.S,
                ),
                DataColumn(
                  label: Text('Username',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Full Name',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Date Registered',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
              rows: tableDatas != null && tableDatas!.isNotEmpty
                  ? List<DataRow>.generate(
                      tableDatas!.length,
                      (index) => DataRow(cells: [
                        DataCell(Text("${index + 1}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text("${tableDatas![index]["username"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text(
                            "${tableDatas![index]["firstName"]} ${tableDatas![index]["lastName"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text("${tableDatas![index]["regdate"]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                      ]),
                    )
                  : [],
              empty: tableDatas == null
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: CustomText(text: "No data to show", size: 16)),
            ),
          )),
    );
  }
}
