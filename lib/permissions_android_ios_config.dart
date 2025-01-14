/// Android permissions
// for internet =>
//<uses-permission android:name="android.permission.INTERNET" />

//<!-- Android Permissions for local notifications -->
/// Before application tag
//     <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED" />
//     <uses-permission android:name="android.permission.VIBRATE" />
//     <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT" />
//     <uses-permission android:name="android.permission.USE_EXACT_ALARM" />
//     <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
//     <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
//     <uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
//     <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
//     <!-- Android Permissions for local notifications -->

/// Inside activity tag put this =>
// android:turnScreenOn="true"
// android:showWhenLocked="true"

/// Inside application tag put this =>
//<service
//             android:name="com.dexterous.flutterlocalnotifications.ForegroundService"
//             android:exported="false"
//             android:foregroundServiceType="specialUse"
//             android:stopWithTask="false">
//             <property
//                 android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE"
//                 android:value="To demonstrate how to use foreground services to show notifications" />
//         </service>
//
//         <receiver
//             android:name="com.dexterous.flutterlocalnotifications.ActionBroadcastReceiver"
//             android:exported="false" />
//         <receiver
//             android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver"
//             android:exported="false" />
//         <receiver
//             android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver"
//             android:exported="false">
//             <intent-filter>
//                 <action android:name="android.intent.action.BOOT_COMPLETED" />
//                 <action android:name="android.intent.action.MY_PACKAGE_REPLACED" />
//                 <action android:name="android.intent.action.QUICKBOOT_POWERON" />
//                 <action android:name="com.htc.intent.action.QUICKBOOT_POWERON" />
//             </intent-filter>
//         </receiver>

//==================================================================================================//

/// IOS permissions

// Inside AppDelegate file put this =>
// import flutter_local_notifications
//
// FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
//       GeneratedPluginRegistrant.register(with: registry)

//==================================================================================================//
