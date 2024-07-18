import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/helpers/common.dart';
import 'package:surebetcalc/screens/about_us.dart';
import 'package:surebetcalc/screens/all_upcoming_games.dart';
import 'package:surebetcalc/screens/login.dart';
import 'package:surebetcalc/screens/myref_history.dart';
import 'package:surebetcalc/screens/previous_games_results.dart';
import 'package:surebetcalc/screens/profile.dart';
import 'package:surebetcalc/screens/referrall.dart';
import 'package:surebetcalc/screens/vip_tips.dart';
import 'package:surebetcalc/screens/wallet.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:surebetcalc/screens/subscription.dart';
import 'package:surebetcalc/widgets/custom_text.dart';

class Menu extends StatefulWidget {
  final String username;
  Menu({required this.username});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Drawer(
        backgroundColor: Colors.blueGrey[100],
        width: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(15, 30, 20, 8),
              decoration: BoxDecoration(
                color: Color(0xff227324),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/logo.png",
                          height: 50, width: 112, fit: BoxFit.cover),
                    ],
                  ),
                  Spacer(),
                  CustomText(
                      text: widget.username, size: 16, color: Colors.white),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: appColor,
              ),
              title: Text("Arbitrages",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.groups_3,
                color: appColor,
              ),
              title: Text("VIP 4/5 Tips",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, VipTips(username: widget.username));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: appColor,
              ),
              title: Text("About Us",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, AboutUs());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.groups_3,
                color: appColor,
              ),
              title: Text("All Upcoming Games",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(
                    context, AllUpcomingGames(username: widget.username));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.groups_3,
                color: appColor,
              ),
              title: Text("Previous Games Results",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(
                    context, PreviousGamesResults(username: widget.username));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_outline_outlined,
                color: appColor,
              ),
              title: Text("My Referrals",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, MyReferrals());
              },
            ),
            ListTile(
              leading: Icon(
                Icons.credit_card,
                color: appColor,
              ),
              title: Text("My Referral Bonus",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, Referral(username: widget.username));
              },
            ),
            Platform.isAndroid
                ? ListTile(
                    leading: Icon(
                      Icons.shop,
                      color: appColor,
                    ),
                    title: Text("Subscription",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    onTap: () {
                      changeScreen(context, Subscription());
                    },
                  )
                : SizedBox(),
            ListTile(
              leading: Icon(
                Icons.wallet,
                color: appColor,
              ),
              title: Text("Wallet",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, Wallet(username: widget.username));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_3,
                color: appColor,
              ),
              title: Text("Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, Profile());
              },
            ),
            /* ListTile(
              leading: Icon(
                Icons.calculate,
                color: appColor,
              ),
              title: Text("Bet Calculator",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                changeScreen(context, BetCalc());
              },
            ),*/
            ListTile(
              leading: Icon(
                Icons.logout,
                color: appColor,
              ),
              title: Text("Logout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              onTap: () {
                LocalStorage().setString("username", "");
                appProvider.removeUser();
                changeScreenRemoveUntill(context, Login());
              },
            )
          ],
        ),
      ),
    );
  }
}
