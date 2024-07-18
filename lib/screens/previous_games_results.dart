import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class PreviousGamesResults extends StatefulWidget {
  final String username;
  PreviousGamesResults({required this.username, super.key});

  @override
  State<PreviousGamesResults> createState() => _PreviousGamesResultsState();
}

class _PreviousGamesResultsState extends State<PreviousGamesResults> {
  late AppProvider appProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getPrevGamesResults(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    appProvider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
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
            text: "Previous Games VIP Tips",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await appProvider.getPrevGamesResults(widget.username);
          },
          child: appProvider.prevGamesRes != null
              ? appProvider.prevGamesRes!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: ListView.separated(
                          itemCount: appProvider.prevGamesRes!.length,
                          itemBuilder: (context, index) {
                            String dte = appProvider.prevGamesRes![index]
                                    ["date"]
                                .toString()
                                .replaceAll("-", "");
                            DateTime time = DateTime(
                                    int.parse(dte.substring(0, 4)),
                                    int.parse(dte.substring(4, 6)),
                                    int.parse(dte.substring(6, 8)),
                                    0,
                                    0,
                                    int.parse(appProvider.prevGamesRes![index]
                                        ["contime"]))
                                .toUtc();

                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 90,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text:
                                              "${appProvider.prevGamesRes![index]["date"]}",
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        CustomText(
                                          text:
                                              "${time.hour.toString().length < 2 ? "0${time.hour}" : time.hour}:${time.minute.toString().length < 2 ? "0${time.minute}" : time.minute}:${time.second.toString().length < 2 ? "0${time.second}" : time.second}",
                                        )
                                      ],
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      GoogleFonts.poppins()
                                                          .fontFamily,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                            TextSpan(
                                                text: appProvider
                                                        .prevGamesRes![index]
                                                    ["home"]),
                                            TextSpan(
                                                text:
                                                    "(${appProvider.prevGamesRes![index]["homegoal"]})",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            TextSpan(text: "-"),
                                            TextSpan(
                                                text: appProvider
                                                        .prevGamesRes![index]
                                                    ["away"]),
                                            TextSpan(
                                                text:
                                                    "(${appProvider.prevGamesRes![index]["awaygoal"]})",
                                                style: TextStyle(
                                                    color: Colors.red))
                                          ])),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                        text:
                                            "${appProvider.prevGamesRes![index]["country"]} - ${appProvider.prevGamesRes![index]["league"]}",
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 80,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text:
                                            "${appProvider.prevGamesRes![index]["pn1"]}",
                                        size: 12,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                        text:
                                            "${appProvider.prevGamesRes![index]["pn2"]}",
                                        size: 12,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      CustomText(
                                        text:
                                            "${appProvider.prevGamesRes![index]["pn3"]}",
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                                height: 30,
                                thickness: 3,
                              )),
                    )
                  : Center(child: CustomText(text: "No previous games to show"))
              : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
