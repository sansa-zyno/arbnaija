import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surebetcalc/constants/api.dart';
import 'package:surebetcalc/services/local_storage.dart';
import '../services/http.service.dart';

class AppProvider extends ChangeNotifier {
  //String? imageUrl;
  //String? email;
  Map? profileDetails;
  String? subscriptionStatus;
  String? expiryDate;
  List? tips;
  List? notificationList;
  List newNotificationsList = [];
  String? walletBalance;
  String? referralLink;
  List? withdrawalHistory;
  List? refHistory;
  String? refBalance;
  List? vipTips;
  List? allUpcomingGames;
  List? prevGamesRes;

  AppProvider() {}

  /*Future<String> getUsername() async {
    String username = await LocalStorage().getString("username");
    return username;
  }*/

  /*getImage(String username) async {
    try {
      Response res = await HttpService.post("", {"username": username});
      imageUrl = jsonDecode(res.data)[0]["avatar"];
    } catch (e) {
      imageUrl = null;
    }
    notifyListeners();
  }*/
  getProFileDetails(String username) async {
    Response res =
        await HttpService.post(Api.getProfile, {"username": username});
    profileDetails = jsonDecode(res.data)[0];
    notifyListeners();
  }

  /*getEmail(String username) async {
    Response res = await HttpService.post(Api.getEmail, {"username": username});
    email = jsonDecode(res.data)[0]["email"];
    notifyListeners();
  }*/

  Future<void> getSubscriptionStatus(String username) async {
    Response res =
        await HttpService.post(Api.subscriptionStatus, {"username": username});
    subscriptionStatus = res.data;
    log(subscriptionStatus!);
    notifyListeners();
  }

  getTips(String endpoint, String username) async {
    Response res = await HttpService.post(endpoint, {"username": username});
    tips = jsonDecode(res.data.toString().replaceAll("	", ""));
    log(tips.toString());
    notifyListeners();
  }

  getExpiryDate(String username) async {
    Response res =
        await HttpService.post(Api.getExpDate, {"username": username});
    expiryDate = jsonDecode(res.data)[0]["ExpiryDate"];
    if (expiryDate != null) {
      await LocalStorage().setString("expiryDate", expiryDate!);
    }

    notifyListeners();
  }

  Future getNotifications() async {
    String? notificationString =
        await LocalStorage().getString("notifications");
    notificationList =
        notificationString != null ? jsonDecode(notificationString) : [];
    notifyListeners();
  }

  addToNewNotificationsList(List list) {
    newNotificationsList = list;
    notifyListeners();
  }

  getWalletBalance(String username) async {
    Response res =
        await HttpService.post(Api.walletBalance, {"username": username});
    walletBalance = res.data;
    notifyListeners();
  }

  getReferralLink(String username) async {
    Response res =
        await HttpService.post(Api.referralLink, {"username": username});
    referralLink = res.data;
    notifyListeners();
  }

  getWithdrawalHistory(String username) async {
    Response res =
        await HttpService.post(Api.withdrawalHistory, {"username": username});
    withdrawalHistory = jsonDecode(res.data);
    notifyListeners();
  }

  getRefHistory(String username) async {
    Response res =
        await HttpService.post(Api.refHistory, {"username": username});
    refHistory = jsonDecode(res.data);
    notifyListeners();
  }

  getRefBalance(String username) async {
    Response res =
        await HttpService.post(Api.refBalance, {"username": username});
    refBalance = jsonDecode(res.data).toString();
    notifyListeners();
  }

  getVIPTips(String endpoint, String username) async {
    Response res = await HttpService.post(endpoint, {"username": username});
    vipTips = jsonDecode(res.data.toString().replaceAll("	", ""));
    notifyListeners();
  }

  getAllUpcomingGames(String username) async {
    Response res =
        await HttpService.post(Api.allUpcomingGames, {"username": username});
    allUpcomingGames = jsonDecode(res.data.toString().replaceAll("	", ""));
    notifyListeners();
  }

  getPrevGamesResults(String username) async {
    Response res =
        await HttpService.post(Api.prevGamesRes, {"username": username});
    prevGamesRes = jsonDecode(res.data.toString().replaceAll("	", ""));
    log(prevGamesRes.toString());
    notifyListeners();
  }

  removeUser() {
    //imageUrl = null;
    //email = null;
    profileDetails = null;
    subscriptionStatus = null;
    expiryDate = null;
    tips = null;
    notificationList = null;
    newNotificationsList = [];
    walletBalance = null;
    referralLink = null;
    withdrawalHistory = null;
    refHistory = null;
    refBalance = null;
    vipTips = null;
    allUpcomingGames = null;
    prevGamesRes = null;
    notifyListeners();
  }
}
