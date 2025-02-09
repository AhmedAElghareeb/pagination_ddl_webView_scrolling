// // import 'dart:io';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest_all.dart' as tz;
// // import 'package:timezone/timezone.dart' as tz;
// // import 'package:flutter/material.dart';
//
// // class NotificationService {
// //   static final NotificationService _instance = NotificationService._internal();
// //
// //   factory NotificationService() {
// //     return _instance;
// //   }
// //
// //   NotificationService._internal();
// //
// //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// //       FlutterLocalNotificationsPlugin();
// //
// //   Future<void> init() async {
// //     final androidPlugin =
// //         flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
// //             AndroidFlutterLocalNotificationsPlugin>();
// //     final bool? granted = await androidPlugin?.requestNotificationsPermission();
// //     print('Notification Permission Granted: $granted');
// //     tz.initializeTimeZones();
// //     tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
// //     print('local name: ${tz.getLocation(tz.local.name)}');
// //     const AndroidInitializationSettings initializationSettingsAndroid =
// //         AndroidInitializationSettings('@mipmap/ic_launcher');
// //
// //     const DarwinInitializationSettings initializationSettingsIOS =
// //         DarwinInitializationSettings(
// //       requestAlertPermission: true,
// //       requestBadgePermission: true,
// //       requestSoundPermission: true,
// //     );
// //
// //     const InitializationSettings initializationSettings =
// //         InitializationSettings(
// //       android: initializationSettingsAndroid,
// //       iOS: initializationSettingsIOS,
// //     );
// //
// //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
// //   }
// //
// //   Future<void> makeNotify(int id, DateTime dateTime) async {
// //     final tz.TZDateTime scheduledTime = tz.TZDateTime.from(dateTime, tz.local);
// //
// //     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
// //       'sound_channel',
// //       'myApp',
// //       channelDescription: 'This channel is used for notifications.',
// //       priority: Priority.high,
// //       importance: Importance.max,
// //       playSound: true,
// //       autoCancel: false,
// //       fullScreenIntent: Platform.isAndroid ? false : true,
// //       enableVibration: true,
// //       enableLights: true,
// //       ticker: 'ticker',
// //     );
// //
// //     const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails(
// //       presentSound: true,
// //     );
// //
// //     NotificationDetails platformDetails = NotificationDetails(
// //       android: androidDetails,
// //       iOS: iOSDetails,
// //     );
// //
// //     try {
// //       await flutterLocalNotificationsPlugin.zonedSchedule(
// //         id,
// //         "Hello",
// //         "Hello, Developer",
// //         scheduledTime,
// //         platformDetails,
// //         androidAllowWhileIdle: true,
// //         uiLocalNotificationDateInterpretation:
// //             UILocalNotificationDateInterpretation.absoluteTime,
// //       );
// //       debugPrint('Notification scheduled for $scheduledTime');
// //     } catch (e) {
// //       debugPrint('Error scheduling notification: $e');
// //     }
// //   }
// // }
//
// //====================================================
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:flutter_timezone/flutter_timezone.dart';
// // import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class LocalNotifications {
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   // static final onClickNotification = BehaviorSubject<String>();
//
// // on tap on any notification
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     if (notificationResponse.payload != null) {
//       // onClickNotification.add(notificationResponse.payload!);
//     }
//   }
//
// // initialize the local notifications
//   static Future init() async {
//     // initialize timeZone
//     tz.initializeTimeZones();
//     // final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
//     // tz.setLocalLocation(tz.getLocation(currentTimeZone));
//     // debugPrint('local name: $currentTimeZone');
//
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) async {},
//     );
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux,
//     );
//
//     // request notification permissions
//     /// Android Permission
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();
//
//     /// IOS Permission
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//
//     /// Initialize local notifications
//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onNotificationTap,
//       onDidReceiveBackgroundNotificationResponse: onNotificationTap,
//     );
//   }
//
//   ///===================================================================///
//   // show a simple notification
//   static Future showSimpleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     try {
//       const AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         'your_channel_id',
//         'your_channel_name',
//         channelDescription: 'your channel description',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//       );
//       await _flutterLocalNotificationsPlugin.show(
//         0,
//         title,
//         body,
//         notificationDetails,
//         payload: payload,
//       );
//       debugPrint('Simple Ahmed => $title $body');
//     } catch (e) {
//       debugPrint('Error showing notification: $e');
//     }
//   }
//
//   ///===================================================================///
//   // to show periodic notification at regular interval
//   static Future showPeriodicNotifications({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     try {
//       const AndroidNotificationDetails androidNotificationDetails =
//           AndroidNotificationDetails(
//         'repeating_channel_id',
//         'repeating_channel_name',
//         channelDescription: 'repeating_description',
//       );
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//       );
//       await _flutterLocalNotificationsPlugin.periodicallyShow(
//         1,
//         title,
//         body,
//         RepeatInterval.daily,
//         notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         androidAllowWhileIdle: true,
//         payload: payload,
//       );
//       debugPrint('Periodic Ahmed => $title $body');
//     } catch (e) {
//       debugPrint('Error showing notification: $e');
//     }
//   }
//
//   // // to show periodic duration Notifications at regular interval
//   // static Future showPeriodicDurationNotifications({
//   //   required String title,
//   //   required String body,
//   //   required String payload,
//   // }) async {
//   //   try {
//   //     const AndroidNotificationDetails androidNotificationDetails =
//   //         AndroidNotificationDetails(
//   //       'repeating_channel_id',
//   //       'repeating_channel_name',
//   //       channelDescription: 'repeating_description',
//   //     );
//   //     const NotificationDetails notificationDetails = NotificationDetails(
//   //       android: androidNotificationDetails,
//   //     );
//   //     await _flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
//   //       1,
//   //       title,
//   //       body,
//   //       const Duration(seconds: 5),
//   //       notificationDetails,
//   //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//   //       payload: payload,
//   //     );
//   //     debugPrint('Periodic Ahmed => $title $body');
//   //   } catch (e) {
//   //     debugPrint('Error showing notification: $e');
//   //   }
//   // }
//
//   ///===================================================================///
//   // to schedule a local notification
//   // Mohamed Gamal Not Working
//   static Future showScheduleNotification2({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     try {
//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         2,
//         title,
//         body,
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'your_channel_id',
//             'your_channel_name',
//             channelDescription: 'your_channel_description',
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         payload: payload,
//       );
//       await Future.delayed(
//         const Duration(seconds: 3),
//         () async {
//           await showScheduleNotification(
//               title: title, body: body, payload: payload);
//         },
//       );
//       debugPrint('Scheduled Ahmed => $title $body');
//     } catch (e) {
//       debugPrint('Error showing notification: $e');
//     }
//   }
//
//   ///===================================================================///
//   // Mohamed Gamal
//   // to schedule a local notification
//   static Future showScheduleNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     try {
//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         2,
//         title,
//         body,
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//             'your_channel_id',
//             'your_channel_name',
//             channelDescription: 'your_channel_description',
//           ),
//         ),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         payload: payload,
//       );
//       await Future.delayed(
//         const Duration(seconds: 5),
//         () async {
//           await showScheduleNotification(
//               title: title, body: body, payload: payload);
//         },
//       );
//       debugPrint('Scheduled Ahmed => $title $body');
//     } catch (e) {
//       debugPrint('Error showing notification: $e');
//     }
//   }
//
//   ///===================================================================///
// // close a specific channel notification
//   static Future cancel(int id) async {
//     await _flutterLocalNotificationsPlugin.cancel(id);
//     debugPrint('Ahmed => Notification of id $id Cancelled');
//   }
//
//   ///===================================================================///
// // close all the notifications available
//   static Future cancelAll() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//     debugPrint('Ahmed => All Notifications Cancelled');
//   }
// }
