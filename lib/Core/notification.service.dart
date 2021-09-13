import 'dart:convert';

import 'package:bumaba/Config/app.dart';
import 'package:bumaba/models/notification_model.dart';

import 'local_storage.dart';

class NotificationService {
  //
  static Future<List<NotificationModel>> getNotifications() async {
    //
    final notificationsStringList = LocalStorageService.prefs.getString(
      AppStrings.notificationsKey,
    );

    if (notificationsStringList == null) {
      return [];
    }

    return (jsonDecode(notificationsStringList) as List)
        .asMap()
        .entries
        .map((notificationObject) {
      //
      return NotificationModel(
        index: notificationObject.key,
        title: notificationObject.value["title"],
        body: notificationObject.value["body"],
        timeStamp: notificationObject.value["timeStamp"],
      );
    }).toList();
  }

  static void addNotification(NotificationModel notification) async {
    //
    final notifications = await getNotifications() ?? [];
    notifications.insert(0,notification);

    //
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }

  static void updateNotification(NotificationModel notificationModel) async {
    //
    final notifications = await getNotifications();
    notifications.removeAt(notificationModel.index);
    notifications.insert(notificationModel.index, notificationModel);
    await LocalStorageService.prefs.setString(
      AppStrings.notificationsKey,
      jsonEncode(notifications),
    );
  }
}
