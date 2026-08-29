import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static Future<void> initialNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: 'high_importance_channel',
          channelName: 'Basic Notification',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          onlyAlertOnce: true,
          criticalAlerts: true,
          ledColor: Colors.white,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'high_importance_channel_group',
          channelGroupName: 'Grouped 1',
        )
      ],
      debug: true,
    );

    // bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    // if (!isAllowed) {
    //   await AwesomeNotifications().requestPermissionToSendNotifications();
    // }

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification created: ${receivedNotification.title}');
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification displayed: ${receivedNotification.title}');
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('notification dismissed: ${receivedAction.id}');
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('notification action received: ${receivedAction.id}');
    final payload = receivedAction.payload;
    if (payload != null) {
      debugPrint('Payload: $payload');
    }
  }

static Future<bool> showNotification({
  required final String title,
  required final String body,
  final String? summary,
  final Map<String, String>? payload,
  final ActionType actionType = ActionType.Default,
  final NotificationLayout notificationLayout = NotificationLayout.Default,
  final NotificationCategory? category,
  final String? bigPicture,
  final List<NotificationActionButton>? actionButtons,
  final bool scheduled = false,
  final int? interval,
}) async {
  assert(!scheduled || (scheduled && interval != null));
  bool allowed =
      await AwesomeNotifications().requestPermissionToSendNotifications();
  if (allowed) {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'high_importance_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: payload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval != null ? Duration(seconds: interval) : null,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  } else {
    allowed = await AwesomeNotifications().isNotificationAllowed();
    if (allowed) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: -1,
          channelKey: 'high_importance_channel',
          title: title,
          body: body,
          actionType: actionType,
          notificationLayout: notificationLayout,
          summary: summary,
          category: category,
          payload: payload,
          bigPicture: bigPicture,
        ),
        actionButtons: actionButtons,
        schedule: scheduled
            ? NotificationInterval(
                interval: interval != null ? Duration(seconds: interval) : null,
                timeZone:
                    await AwesomeNotifications().getLocalTimeZoneIdentifier(),
                preciseAlarm: true,
              )
            : null,
      );
    }
  }
  return allowed;
}

  static Future<void> scheduleNotificationsForEvent(
      String description, DateTime startDate, DateTime endDate) async {
    await _scheduleNotification(
      description,
      'Application Period starts in one week!',
      startDate.subtract(const Duration(days: 7)),
    );
    await _scheduleNotification(
      description,
      'Application Period starts tomorrow!',
      startDate.subtract(const Duration(days: 1)),
    );
    await _scheduleNotification(
      description,
      'Application Period ends in one week!',
      endDate.subtract(const Duration(days: 7)),
    );
    await _scheduleNotification(
      description,
      'Application Period ends tomorrow!',
      endDate.subtract(const Duration(days: 1)),
    );
  }

  static Future<bool> _scheduleNotification(
      String description, String body, DateTime dateTime) async {
    bool allowed = await AwesomeNotifications().isNotificationAllowed();
    if (allowed) {
      int uniqueId = _generateDeterministicId(description, body);
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: uniqueId,
          channelKey: 'high_importance_channel',
          title: description,
          body: body,
          notificationLayout: NotificationLayout.Default,
        ),
        schedule: NotificationCalendar.fromDate(date: dateTime),
      );
    }
    return allowed;
  }

  static int _generateDeterministicId(String title, String body) {
    String key = "$title|$body";
    int hash = 0;
    for (int i = 0; i < key.length; i++) {
      hash = (hash * 31 + key.codeUnitAt(i)) & 0x7FFFFFFF;
    }
    return hash;
  }
}
