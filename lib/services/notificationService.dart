import 'dart:ui';


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
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }


  @pragma("vm:entry-point")
  static Future <void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification created');
  }


  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future <void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    debugPrint('notification displayed');
    // Your code goes here
  }


  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future <void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
    debugPrint('notification dismissed');
  }


  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future <void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint('notification action received');
    final payload = receivedAction.payload ?? ();
    // define something
    // Your code goes here
  }


  static Future<void> showNotification(
      {
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
        final int? interval
      }) async {
    assert(!scheduled || (scheduled && interval !=null));
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
      schedule:
      scheduled? NotificationInterval(
        interval: interval,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        preciseAlarm: true,
      ):null,
    );
  }


}
