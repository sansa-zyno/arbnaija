import 'dart:async';
import 'dart:math';
import 'dart:ui';
//import 'dart:developer' as dev;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surebetcalc/constants/app_colors.dart';
import 'package:surebetcalc/controller/app_provider.dart';
import 'package:surebetcalc/screens/home.dart';
import 'package:surebetcalc/screens/login.dart';
import 'package:surebetcalc/services/local_storage.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:surebetcalc/services/notification.service.dart';
import 'package:upgrader/upgrader.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: false,

      notificationChannelId:
          NotificationService.appNotificationChannel().channelKey!,
      initialNotificationTitle: 'Arbnaija app background service',
      initialNotificationContent: 'Background notification to keep app running',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  //service.startService();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterStatusbarcolor.setStatusBarColor(Color(0xff227324));
  await NotificationService.initializeAwesomeNotification();
  await NotificationService.listenToActions();
  await initializeBackgroundService();
  runApp(const MyApp());
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  Timer.periodic(const Duration(minutes: 1), (timer) async {
    String? expiryDate = await prefs.getString("expiryDate");
    if (expiryDate != null) {
      DateTime expiryDateTime = DateTime.parse(expiryDate);
      DateTime now = DateTime.now();
      if (expiryDateTime
              .difference(DateTime(now.year, now.month, now.day))
              .inDays ==
          7) {
        String? showed = await prefs.getString("showed");
        if (showed == null || showed != "${now.year}-${now.month}-${now.day}") {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: Random().nextInt(20),
                channelKey:
                    NotificationService.appNotificationChannel().channelKey!,
                title: "",
                body: "Your subscription would expire in 7 days",
                icon: "resource://drawable/res_launcher_icon",
                // notificationLayout: NotificationLayout.BigPicture,
                //bigPicture: "resource://drawable/launcher_icon",
                payload: {
                  //"image": "assets/hand_up.png",
                  "title": "Your subscription would expire in 7 days",
                  "date": DateTime.now().toString(),
                  "read": "0"
                }),
          );
          await prefs.setString(
              "showed", "${now.year}-${now.month}-${now.day}");
        }
      } else if (expiryDateTime
              .difference(DateTime(now.year, now.month, now.day))
              .inDays ==
          0) {
        String? showed2 = await prefs.getString("showed2");
        if (showed2 == null ||
            showed2 != "${now.year}-${now.month}-${now.day}") {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: Random().nextInt(20),
                channelKey:
                    NotificationService.appNotificationChannel().channelKey!,
                title: "",
                body: "Your subscription has expired",
                icon: "resource://drawable/res_launcher_icon",
                // notificationLayout: NotificationLayout.BigPicture,
                //bigPicture: "resource://drawable/launcher_icon",
                payload: {
                  //"image": "assets/hand_up.png",
                  "title": "Your subscription has expired",
                  "date": DateTime.now().toString(),
                  "read": "0"
                }),
          );
          await prefs.setString(
              "showed2", "${now.year}-${now.month}-${now.day}");
        }
      }
    }
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? expiryDate = await prefs.getString("expiryDate");
  if (expiryDate != null) {
    DateTime expiryDateTime = DateTime.parse(expiryDate);
    DateTime now = DateTime.now();
    if (expiryDateTime
            .difference(DateTime(now.year, now.month, now.day))
            .inDays ==
        7) {
      String? showed = await prefs.getString("showed");
      if (showed == null || showed != "${now.year}-${now.month}-${now.day}") {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(20),
              channelKey:
                  NotificationService.appNotificationChannel().channelKey!,
              title: "",
              body: "Your subscription would expire in 7 days",
              icon: "resource://drawable/res_launcher_icon",
              // notificationLayout: NotificationLayout.BigPicture,
              //bigPicture: "resource://drawable/launcher_icon",
              payload: {
                //"image": "assets/hand_up.png",
                "title": "Your subscription would expire in 7 days",
                "date": DateTime.now().toString(),
                "read": "0"
              }),
        );
        await prefs.setString("showed", "${now.year}-${now.month}-${now.day}");
      }
    } else if (expiryDateTime
            .difference(DateTime(now.year, now.month, now.day))
            .inDays ==
        0) {
      String? showed2 = await prefs.getString("showed2");
      if (showed2 == null || showed2 != "${now.year}-${now.month}-${now.day}") {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: Random().nextInt(20),
              channelKey:
                  NotificationService.appNotificationChannel().channelKey!,
              title: "",
              body: "Your subscription has expired",
              icon: "resource://drawable/res_launcher_icon",
              // notificationLayout: NotificationLayout.BigPicture,
              //bigPicture: "resource://drawable/launcher_icon",
              payload: {
                //"image": "assets/hand_up.png",
                "title": "Your subscription has expired",
                "date": DateTime.now().toString(),
                "read": "0"
              }),
        );
        await prefs.setString("showed2", "${now.year}-${now.month}-${now.day}");
      }
    }
  }

  return true;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String? username;

  bool? rememberMe;

  bool loading = false;

  getUserData() async {
    loading = true;
    setState(() {});
    username = await LocalStorage().getString("username");
    if (username == null) {
      username = "";
    }
    rememberMe = await LocalStorage().getBool("rememberMe");

    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppProvider>(
      create: (context) => AppProvider(),
      child: MaterialApp(
          title: 'Arbnaija',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          home: UpgradeAlert(
            child: loading
                ? SafeArea(
                    child: Scaffold(
                        body: Center(
                            child: CircularProgressIndicator(
                      color: appColor,
                    ))),
                  )
                : username != ""
                    //accepting null because remember me isnt in register screen
                    ? rememberMe == null || rememberMe!
                        ? Home(username: username!)
                        : Login()
                    : Login(),
          )),
    );
  }
}
