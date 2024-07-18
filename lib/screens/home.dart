import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/notifications.dart';
import 'package:surebetcalc/screens/subscription.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:surebetcalc/widgets/custom_webview.page.dart';
import 'package:surebetcalc/widgets/menu.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({required this.username, Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late AppProvider appProvider;
  //late ScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //scrollController = ScrollController();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getSubscriptionStatus(widget.username).then((value) {
      if (appProvider.subscriptionStatus == "0") {
        appProvider.getTips(Api.unsubscribedMember, widget.username);
      } else if (appProvider.subscriptionStatus == "1") {
        appProvider.getExpiryDate(widget.username);
        appProvider.getTips(Api.subscribedMember, widget.username);
      } else {}
    });
    appProvider.getProFileDetails(widget.username);
    appProvider.getReferralLink(widget.username);
    Timer.periodic(Duration(seconds: 1), (_) async {
      await appProvider.getNotifications();
      List newNotifications = appProvider.notificationList!
          .where((element) => element["read"] == "0")
          .toList();
      appProvider.addToNewNotificationsList(newNotifications);
    });
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        if (scrollController.position.pixels == 100) {
          log("offset");
        }
      }
    });*/
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: Color(0xff227324),
            surfaceTintColor: Colors.transparent,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            title: Image.asset(
              "assets/logo.png",
              height: 50,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                    onTap: () {
                      changeScreen(
                          context, Notifications(username: widget.username));
                    },
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 8,
                              child: CustomText(
                                text:
                                    "${appProvider.newNotificationsList.length}",
                                color: Color(0xFFE8332C),
                                size: 11,
                              ),
                            ))
                      ],
                    )),
              )
            ],
          ),
          drawer: Menu(
            username: widget.username,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              if (appProvider.subscriptionStatus == "0") {
                await appProvider.getTips(
                    Api.unsubscribedMember, widget.username);
              } else if (appProvider.subscriptionStatus == "1") {
                await appProvider.getExpiryDate(widget.username);
                await appProvider.getTips(
                    Api.subscribedMember, widget.username);
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
                                border: Border.all(
                                    color: Colors.black26, width: 1.2),
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
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: CustomText(
                        text: "Promo Link",
                        size: 16,
                        weight: FontWeight.bold,
                      )),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      bottomLeft: Radius.circular(8))),
                              child: Center(
                                  child: CustomText(
                                      text: appProvider.referralLink ?? "")),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                      text: appProvider.referralLink ?? ""))
                                  .then((_) => ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Link copied to clipboard",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.green[400],
                                      )));
                            },
                            child: Container(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8))),
                              child: Center(
                                  child: CustomText(
                                text: "Copy",
                                color: Color(0xff227324),
                                weight: FontWeight.bold,
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: appProvider.tips == null
                      ? Center(
                          child: CircularProgressIndicator(color: appColor))
                      : appProvider.tips!.isEmpty
                          ? Center(
                              child: CustomText(text: "No arbitrage to show"))
                          : ListView.builder(
                              //controller: scrollController,
                              itemCount: appProvider.tips!.length,
                              itemBuilder: (context, index) {
                                List games = appProvider.tips![index]["Games"];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, left: 8, right: 8),
                                  child: Column(children: [
                                    Container(
                                      color: Color(0xffF2F2F2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8),
                                          CustomText(
                                              text:
                                                  "${appProvider.tips![index]["PercentagePoint"]}%"),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          CustomText(
                                              text:
                                                  "${appProvider.tips![index]["Date"]}"),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          CustomText(
                                              text:
                                                  "${appProvider.tips![index]["Duration"]}"),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          CustomText(
                                              text:
                                                  "${appProvider.tips![index]["SportName"]}",
                                              weight: FontWeight.bold),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: appColor.withOpacity(0.2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            games.length,
                                            (index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 15),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                          width: 60,
                                                          child: CustomText(
                                                            text:
                                                                "${games[index]["Bookmaker"]}",
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
                                                              weight: FontWeight
                                                                  .w700,
                                                              color: appColor,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            CustomText(
                                                              text:
                                                                  "${games[index]["Country"]} - ${games[index]["LeageName"]}",
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
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            CustomText(
                                                              text:
                                                                  "${games[index]["Odds"]}",
                                                              size: 12,
                                                              color: appColor,
                                                              weight: FontWeight
                                                                  .w700,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ]),
                                );
                              }),
                ),
              ],
            ),
          )),
    );
  }
}
