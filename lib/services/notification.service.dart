import 'dart:convert';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:surebetcalc/services/local_storage.dart';

@pragma('vm:entry-point')
Future<void> onActionReceived(ReceivedAction receivedAction) async {
  //FlutterBackgroundService().invoke("stopSound");
}

@pragma('vm:entry-point')
Future<void> onNotificationDisplayed(
    ReceivedNotification receivedNotification) async {
  if (receivedNotification.payload != null) {
    //To only save when notification is prayer type
    String? notificationString =
        await LocalStorage().getString("notifications");
    List notificationList =
        notificationString != null ? jsonDecode(notificationString) : [];
    notificationList.insert(0, {
      //"image": receivedNotification.payload!["image"],
      "title": receivedNotification.payload!["title"],
      "date": receivedNotification.payload!["date"],
      "read": receivedNotification.payload!["read"],
    });
    await LocalStorage()
        .setString("notifications", jsonEncode(notificationList));
    log(notificationList.toString());
  }
}

@pragma('vm:entry-point')
Future<void> onNotificationDismissed(ReceivedAction receivedAction) async {
  //FlutterBackgroundService().invoke("stopSound");
}

class NotificationService {
  static initializeAwesomeNotification() async {
    await AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_launcher_icon',
      [
        appNotificationChannel(),
      ],
    );
    //requet notifcation permission if not allowed
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static NotificationChannel appNotificationChannel() {
    return NotificationChannel(
        channelKey: 'Arbnaija',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for Arbnaija app',
        importance: NotificationImportance.High,
        //soundSource: "resource://raw/res_dorime",
        playSound: true);
  }

  static listenToActions() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceived,
        onNotificationDisplayedMethod: onNotificationDisplayed,
        onDismissActionReceivedMethod: onNotificationDismissed);
  }
}
