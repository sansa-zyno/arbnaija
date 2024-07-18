import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/modals/alert.dart';
import 'package:surebetcalc/services/http.service.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/GradientButton/GradientButton.dart';
import 'package:surebetcalc/widgets/curved_textfield.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class Withdraw extends StatefulWidget {
  const Withdraw({super.key});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final _formKey = GlobalKey<FormState>();
  late AppProvider appProvider;
  late TextEditingController amtController;
  late TextEditingController bankNameController;
  late TextEditingController accountNoController;
  late TextEditingController accountNameController;
  String? username;
  getusername() async {
    username = await LocalStorage().getString("username");
  }

  bool loading = false;
  withdrawFund() async {
    loading = true;
    setState(() {});
    final res = await HttpService.post(Api.withdrawFunds, {
      "username": username,
      "amount": amtController.text,
      "bankname": bankNameController.text,
      "accountno": accountNoController.text,
      "accountname": accountNameController.text
    });
    final result = jsonDecode(res.data);
    print(result);
    if (result["Status"] == "succcess") {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                image: "assets/hand_up.png",
                titleText: result["Report"],
                subText: "",
              ));
      amtController.text = "";
      appProvider.getWalletBalance(username!);
    } else {
      showDialog(
          context: context,
          builder: (ctx) => ShowDialogWidget(
                titleText: result["Report"],
                subText: "",
              ));
    }
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    getusername();
    amtController = TextEditingController(text: "");
    bankNameController = TextEditingController(
        text: appProvider.profileDetails?["bankName"] ?? "");
    accountNoController = TextEditingController(
        text: appProvider.profileDetails?["AccountNumber"] ?? "");
    accountNameController = TextEditingController(
        text: appProvider.profileDetails?["AccountName"] ?? "");
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
              color: Colors.white,
              size: 20,
            ),
          ),
          title: CustomText(
            text: "Withdraw",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xffF9F8F8),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Bank Account Information",
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                      text:
                          "Fill in your bank account information to place withdrawal"),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    controller: accountNameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Account Number",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    type: TextInputType.number,
                    controller: accountNoController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Bank Name",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    controller: bankNameController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomText(
                    text: "Amount",
                    size: 16,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CurvedTextField(
                    type: TextInputType.number,
                    controller: amtController,
                    validator: (value) {
                      if (value == "") {
                        return "This field must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  loading
                      ? Center(child: CircularProgressIndicator())
                      : GradientButton(
                          title: "Withdraw",
                          textClr: Colors.white,
                          clrs: [appColor, appColor],
                          onpressed: () {
                            if (_formKey.currentState!.validate()) {
                              int amount = int.parse(amtController.text);
                              if (amount >= 1000) {
                                withdrawFund();
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => ShowDialogWidget(
                                          titleText:
                                              "Minimum withdrawal amount is \u20a61,000",
                                          subText: "",
                                        ));
                              }
                            }
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
