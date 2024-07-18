// import 'package:velocity_x/velocity_x.dart';

class Api {
  static String get baseUrl {
    return "https://arbnaija.com/app";
  }

  static const login = "/login.php";
  static const register = "/signup.php";
  static const forgotPassword = "/forgotpassword.php";
  static const subscribe = "/subscribe.php";
  static const subscriptionStatus = "/subscriptionstatus.php";
  static const subscribedMember = "/subscribedm.php";
  static const unsubscribedMember = "/unsubm.php";
  static const getExpDate = "/getexpdate.php";
  static const getEmail = "/getemail.php";
  static const referralLink = "/referrallink.php";
  static const walletBalance = "/walletbalance.php";
  static const withdrawalHistory = "/withdrawalhistory.php";
  static const refHistory = "/refhistory.php";
  static const withdrawFunds = "/withdrawfunds.php";
  static const updateProfile = "/editprofile.php";
  static const refBalance = "/refballance.php";
  static const getProfile = "/getprofiledetails.php";
  static const subscribedVIP = "/svip.php";
  static const unsubscribedVIP = "/usvip.php";
  static const myRef = "/myref.php";
  static const allUpcomingGames = "/getupbot.php";
  static const prevGamesRes = "/getprevbot.php";
}
