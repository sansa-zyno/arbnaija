import 'dart:convert';
import 'dart:developer';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/home.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  final String username;
  const Notifications({required this.username, super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    appProvider.getNotifications();
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
              changeScreenRemoveUntill(
                  context, Home(username: widget.username));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: CustomText(
            text: "Notifications",
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
              appProvider.notificationList == null
                  ? Expanded(child: Center(child: CircularProgressIndicator()))
                  : appProvider.notificationList!.isEmpty
                      ? Expanded(
                          child: Center(
                              child: CustomText(text: "No notifications")))
                      : Expanded(
                          child: ListView.separated(
                            itemCount: appProvider.notificationList!.length,
                            itemBuilder: (context, index) => InkWell(
                              onTap: () async {
                                log(index.toString());
                                List newList = appProvider.notificationList!;
                                Map removedElement = newList.removeAt(index);
                                newList.insert(index, {
                                  //"image": removedElement["image"],
                                  "title": removedElement["title"],
                                  "date": removedElement["date"],
                                  "read": "1",
                                });
                                await LocalStorage().setString(
                                    "notifications", jsonEncode(newList));
                                await appProvider.getNotifications();
                                /*changeScreen(
                                    context,
                                    BottomNavbar(
                                        username: "",
                                        pageIndex: 0,
                                        newpage: NotificationDetails(
                                            map: appProvider
                                                .notificationList![index])));*/
                              },
                              child: Opacity(
                                opacity: appProvider.notificationList![index]
                                            ["read"] ==
                                        "1"
                                    ? 0.5
                                    : 1,
                                child: Row(children: [
                                  /*CircleAvatar(
                                    radius: 20,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        child: Image.asset(
                                          appProvider.notificationList![index]
                                              ["image"],
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        )),
                                  ),*/
                                  CircleAvatar(
                                    backgroundColor: Color(0xffF2F2F2),
                                    radius: 20,
                                    child: Icon(Icons.subscriptions,
                                        color: Color(0xff227324)),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      text: appProvider.notificationList![index]
                                          ["title"],
                                      size: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: calcTimesAgo(DateTime.parse(
                                              appProvider
                                                      .notificationList![index]
                                                  ["date"])),
                                          size: 12,
                                        ),
                                        //Icon(Icons.more_horiz)
                                      ])
                                ]),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                Divider(height: 30),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
