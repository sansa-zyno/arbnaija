import 'dart:convert';
import 'dart:developer';
import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/constants/app_strings.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/modals/alert.dart';
import 'package:surebetcalc/services/http.service.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/widgets/GradientButton/GradientButton.dart';
import 'package:surebetcalc/widgets/custom_text.dart';
import 'package:uuid/uuid.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  final plugin = PaystackPlugin();
  String? username;
  getusername() async {
    username = await LocalStorage().getString("username");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getusername();
    plugin.initialize(publicKey: pubKey);
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
            text: "Subscription",
            size: 16,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 50,
            ),
            CustomText(
              text:
                  "Subscribe for Higher arbitrage Percentage opportunities and a bonus daily VIP 4 out of 5 Daily TIPS",
              size: 20,
              weight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                text: "Current Subscription",
                color: Color(0xff227324),
                size: 16,
              ),
              CustomText(
                text: appProvider.subscriptionStatus == "1" ? "Active" : "None",
                fontFamily: GoogleFonts.roboto().fontFamily,
                size: 16,
              )
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                text: "Expiry Date",
                color: Color(0xff227324),
                size: 16,
              ),
              CustomText(
                text: appProvider.expiryDate != null
                    ? formatDate(DateTime.parse(appProvider.expiryDate!),
                        [M, ' ', dd, ', ', yyyy])
                    : "None",
                fontFamily: GoogleFonts.roboto().fontFamily,
                size: 16,
              )
            ]),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                text: "Subscription Price",
                color: Color(0xff227324),
                size: 16,
              ),
              CustomText(
                text: "\u20a65,000/month",
                size: 16,
                fontFamily: GoogleFonts.roboto().fontFamily,
              )
            ]),
            SizedBox(height: 100),
            GradientButton(
              title: appProvider.subscriptionStatus == "0"
                  ? "Subscribe Now"
                  : "Extend Subscription",
              textClr: Colors.white,
              clrs: [appColor, appColor],
              onpressed: () async {
                String reference = Uuid().v4();
                if (appProvider.profileDetails != null) {
                  int amount = 5000;
                  //initialize txn from backend(optional)
                  // *pass accesscode only when you have initialized txn from backend, else pass reference
                  // *accesscode is only required if method is checkout.bank or checkout.selectable(default)
                  //recommended to verify checkoutresponse result on your backend
                  try {
                    Charge charge = Charge()
                      ..amount = amount * 100
                      ..reference = reference
                      ..email = appProvider.profileDetails!["email"];
                    CheckoutResponse response = await plugin.checkout(context,
                        method: CheckoutMethod.card,
                        charge: charge,
                        fullscreen: true);
                    Response result = await HttpService.post(Api.subscribe, {
                      "username": username,
                      "status": response.status ? "success" : "declined",
                    });
                    Map res = jsonDecode(result.data);
                    log(res.toString());
                    if (res["Status"] == "succcess") {
                      showDialog(
                          context: context,
                          builder: (ctx) => ShowDialogWidget(
                                image: "assets/hand_up.png",
                                titleText: res["Report"],
                                subText: "",
                              ));
                      appProvider.getTips(Api.subscribedMember, username!);
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) => ShowDialogWidget(
                                titleText: res["Report"],
                                subText: "",
                              ));
                      log("subscription failed");
                    }
                  } on PlatformException catch (e) {
                    //log(e.toString());
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (ctx) => ShowDialogWidget(
                              titleText: e.toString(),
                              subText: "An Error occured",
                            ));
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (ctx) => ShowDialogWidget(
                            titleText: "Your have no email in your profle",
                            subText: "",
                          ));
                }
              },
            ),
            Spacer(),
            Image.asset("assets/card_brands-removebg.png"),
            SizedBox(height: 15)
          ]),
        ),
      ),
    );
  }
}
