import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class Referral extends StatefulWidget {
  final String username;
  const Referral({required this.username, super.key});

  @override
  State<Referral> createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
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
    appProvider.getRefHistory(widget.username);
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
            text: "Referral Bonus",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              /* SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Referrals",
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
              ),*/
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: appProvider.refHistory != null
                    ? appProvider.refHistory!.isNotEmpty
                        ? ListView.separated(
                            itemCount: appProvider.refHistory!.length,
                            itemBuilder: (context, index) => Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          "You earned \u20a6${appProvider.refHistory![index]["amount"]} from referring ${appProvider.refHistory![index]["downliner"]} to Arbnaija",
                                      size: 14,
                                      fontFamily:
                                          GoogleFonts.roboto().fontFamily,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  CustomText(
                                    text: calcTimesAgo(DateTime.now()),
                                    fontFamily: GoogleFonts.roboto().fontFamily,
                                  )
                                ]),
                            separatorBuilder: (context, index) =>
                                Divider(height: 30),
                          )
                        : Center(child: CustomText(text: "No referral bonus"))
                    : Center(child: CircularProgressIndicator()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
