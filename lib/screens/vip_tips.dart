import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/subscription.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:surebetcalc/widgets/custom_webview.page.dart';

class VipTips extends StatefulWidget {
  final String username;
  const VipTips({required this.username, super.key});

  @override
  State<VipTips> createState() => _VipTipsState();
}

class _VipTipsState extends State<VipTips> {
  late AppProvider appProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getSubscriptionStatus(widget.username).then((value) {
      if (appProvider.subscriptionStatus == "0") {
        appProvider.getVIPTips(Api.unsubscribedVIP, widget.username);
      } else if (appProvider.subscriptionStatus == "1") {
        appProvider.getExpiryDate(widget.username);
        appProvider.getVIPTips(Api.subscribedVIP, widget.username);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
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
          text: "VIP 4/5 Tips",
          size: 16,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (appProvider.subscriptionStatus == "0") {
            await appProvider.getVIPTips(Api.unsubscribedVIP, widget.username);
          } else if (appProvider.subscriptionStatus == "1") {
            await appProvider.getExpiryDate(widget.username);
            await appProvider.getVIPTips(Api.subscribedVIP, widget.username);
          } else {}
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Platform.isAndroid
                ? appProvider.subscriptionStatus == "0"
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xffE3FAE3),
                            border:
                                Border.all(color: Colors.black26, width: 1.2),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                text:
                                    "You are currently on a free plan mode, Subscribe to see arbitrage opportunities of higher percentages and a Bonus daily SPECIAL VIP 4 out of 5 TIPS(₦5,000/month)",
                                fontFamily: GoogleFonts.roboto().fontFamily,
                                size: 13,
                              ),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                changeScreen(context, Subscription());
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: CustomText(
                                  text: "Subscribe Now",
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : appProvider.subscriptionStatus == "1" &&
                            appProvider.expiryDate != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    children: [
                                  TextSpan(
                                      text:
                                          "Your Current Subscription will expire on "),
                                  TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      text: formatDate(
                                          DateTime.parse(
                                              appProvider.expiryDate!),
                                          [M, ' ', dd, ', ', yyyy]))
                                ])),
                          )
                        : Container()
                : Container(height: 8),
            Expanded(
              child: appProvider.vipTips == null
                  ? Center(child: CircularProgressIndicator(color: appColor))
                  : appProvider.vipTips!.isEmpty
                      ? Center(
                          child: CustomText(text: "No VIP arbitrage to show"))
                      : ListView.builder(
                          //controller: scrollController,
                          itemCount: appProvider.vipTips!.length,
                          itemBuilder: (context, index) {
                            List games = appProvider.vipTips![index]["Games"];
                            String status =
                                appProvider.vipTips![index]["Ticket Status"];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, left: 8, right: 8),
                              child: Column(children: [
                                Container(
                                  color: status == "Pending"
                                      ? Color(0xffF2F2F2)
                                      : status == "Success"
                                          ? Color(0xff227324)
                                          : Color(0xFFE8332C),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 8),
                                      SizedBox(
                                        width: appProvider.vipTips![index]
                                                        ["Total Odds"]
                                                    .toString()
                                                    .length >
                                                10
                                            ? 100
                                            : null,
                                        child: CustomText(
                                          text:
                                              "${appProvider.vipTips![index]["Total Odds"]}",
                                          color: status == "Pending"
                                              ? null
                                              : Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      CustomText(
                                        text:
                                            "${appProvider.vipTips![index]["Date"]}",
                                        color: status == "Pending"
                                            ? null
                                            : Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      CustomText(
                                        text:
                                            "${appProvider.vipTips![index]["Ticket Name"]}",
                                        color: status == "Pending"
                                            ? null
                                            : Colors.white,
                                      ),
                                      Spacer(),
                                      CustomText(
                                        text:
                                            "${appProvider.vipTips![index]["Number of Games"]}",
                                        weight: FontWeight.bold,
                                        color: status == "Pending"
                                            ? null
                                            : Colors.white,
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                      games.length,
                                      (index) => Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 15),
                                            decoration: BoxDecoration(
                                                color: games[index]["Status"] ==
                                                        "Pending"
                                                    ? appColor.withOpacity(0.2)
                                                    : games[index]["Status"] ==
                                                            "Success"
                                                        ? appColor
                                                        : Colors.red),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    width: 60,
                                                    child: CustomText(
                                                      text:
                                                          "${games[index]["Time"]}",
                                                      color: games[index]
                                                                  ["Status"] ==
                                                              "Pending"
                                                          ? null
                                                          : Colors.white,
                                                    )),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "${games[index]["Games"]}",
                                                        weight: FontWeight.w700,
                                                        //color: appColor,
                                                        color: games[index][
                                                                    "Status"] ==
                                                                "Pending"
                                                            ? null
                                                            : Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            "${games[index]["Country"]} - ${games[index]["LeageName"]}",
                                                        color: games[index][
                                                                    "Status"] ==
                                                                "Pending"
                                                            ? null
                                                            : Colors.white,
                                                        size: 12,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                SizedBox(
                                                  width: 60,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CustomText(
                                                        text:
                                                            "${games[index]["OddType"]}",
                                                        size: 12,
                                                        color: games[index][
                                                                    "Status"] ==
                                                                "Pending"
                                                            ? null
                                                            : Colors.white,
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      CustomText(
                                                        text:
                                                            "${games[index]["Odds"]}",
                                                        size: 12,
                                                        //color: appColor,
                                                        color: games[index][
                                                                    "Status"] ==
                                                                "Pending"
                                                            ? null
                                                            : Colors.white,
                                                        weight: FontWeight.w700,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                ),
                              ]),
                            );
                          }),
            ),
          ],
        ),
      ),
    ));
  }
}
