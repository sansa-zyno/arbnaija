import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/withdraw.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class Wallet extends StatefulWidget {
  final String username;
  const Wallet({required this.username, super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late AppProvider appProvider;
  String calcTimesAgo(DateTime dt) {
    Duration dur = DateTime.now().difference(dt);
    print(dur.inHours);
    if (dur.inSeconds < 60) {
      return "Just now";
    }
    if (dur.inMinutes >= 1 && dur.inMinutes < 60) {
      return dur.inMinutes == 1
          ? "${dur.inMinutes} min"
          : "${dur.inMinutes} mins";
    }
    if (dur.inHours >= 1 && dur.inHours < 60) {
      return dur.inHours == 1 ? "${dur.inHours} hour" : "${dur.inHours} hours";
    }
    if (dur.inHours > 60) {
      DateTime dateNow =
          DateTime.parse(DateTime.now().toString().substring(0, 10));
      DateTime dte = DateTime.parse(dt.toString().substring(0, 10));
      String date = dateNow.compareTo(dte) == 0
          ? "Today"
          : "${dte.year} ${dte.month} ${dte.day}" ==
                  "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 1}"
              ? "Yesterday"
              : formatDate(dte, [M, ' ', dd, ', ', yyyy]);
      return date;
    }
    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getWalletBalance(widget.username);
    //appProvider.getRefBalance(widget.username);
    appProvider.getWithdrawalHistory(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    appProvider = Provider.of<AppProvider>(context);
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
            text: "Wallet",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        changeScreen(context, Withdraw());
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: appColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                  text: "Main Balance",
                                  size: 12,
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    CustomText(
                                      text: "Withdraw",
                                      size: 11,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            CustomText(
                              text: appProvider.walletBalance != null
                                  ? "\u20a6${appProvider.walletBalance}"
                                      .replaceAllMapped(reg, mathFunc)
                                  : "",
                              fontFamily: GoogleFonts.roboto().fontFamily,
                              weight: FontWeight.bold,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  /* InkWell(
                    onTap: () {
                      changeScreen(
                          context, Referral(username: widget.username));
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xffDDDDDD),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                text: "Referral Bonus",
                                size: 12,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          CustomText(
                              text: appProvider.refBalance != null
                                  ? "\u20a6${appProvider.refBalance}"
                                      .replaceAllMapped(reg, mathFunc)
                                  : "",
                              size: 18,
                              weight: FontWeight.bold,
                              fontFamily: GoogleFonts.roboto().fontFamily)
                        ],
                      ),
                    ),
                  )*/
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Transaction History",
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  /*Row(
                    children: [
                      CustomText(text: "Today"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.keyboard_arrow_down)
                    ],
                  )*/
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: appProvider.withdrawalHistory != null
                    ? appProvider.withdrawalHistory!.isNotEmpty
                        ? ListView.separated(
                            itemCount: appProvider.withdrawalHistory!.length,
                            itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                        text:
                                            "Your withdrawal of \u20a6${appProvider.withdrawalHistory![index]["amt"]} ${appProvider.withdrawalHistory![index]["status"] == "0" ? "is being processed" : "has been processed successfully"}",
                                        size: 14,
                                        fontFamily:
                                            GoogleFonts.roboto().fontFamily),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  CustomText(
                                      text: calcTimesAgo(DateTime.now()),
                                      fontFamily:
                                          GoogleFonts.roboto().fontFamily)
                                ]),
                            separatorBuilder: (context, index) =>
                                Divider(height: 30),
                          )
                        : Center(
                            child: CustomText(text: "No withdrawal history"))
                    : Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
