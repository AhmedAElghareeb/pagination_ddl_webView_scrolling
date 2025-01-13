import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final bool? granted = await androidPlugin?.requestNotificationsPermission();
    print('Notification Permission Granted: $granted');
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    print('local name: ${tz.getLocation(tz.local.name)}');
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> makeNotify(int id, DateTime dateTime) async {
    final tz.TZDateTime scheduledTime = tz.TZDateTime.from(dateTime, tz.local);

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'sound_channel',
      'myApp',
      channelDescription: 'This channel is used for notifications.',
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      autoCancel: false,
      fullScreenIntent: Platform.isAndroid ? false : true,
      enableVibration: true,
      enableLights: true,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
      presentSound: true,
    );

    NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        "Hello",
        "Hello, Developer",
        scheduledTime,
        platformDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      debugPrint('Notification scheduled for $scheduledTime');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }
}
