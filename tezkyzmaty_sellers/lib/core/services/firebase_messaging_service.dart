// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tezkyzmaty_sellers/core/theme/color.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String> selectNotificationStream =
    StreamController<String>.broadcast();

// const MethodChannel platform =
//     MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

late String selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
Future<void> notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  print(
    'notification(${notificationResponse.id}) action tapped: '
    '${notificationResponse.actionId} with'
    ' payload: ${notificationResponse.payload}',
  );
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
  return Future<void>.value();
}

Future onSelectNotification(String payload, BuildContext context) async {
  // if (_payload != null && _payload.isNotEmpty) {
  // }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'com.tezkyzmaty_sellers.urgent', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// base class to handle and control push notifications from firebase, singleton class
class NotificationHandlerService {
  NotificationHandlerService(this.context);

  final BuildContext context;

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  late StreamSubscription iosSubscription;

  Future<void> initializeFcmNotification(BuildContext context) async {
    const initializationSettingsAndroid = AndroidInitializationSettings(
      'mipmap/ic_launcher',
    );

    final List<DarwinNotificationCategory> darwinNotificationCategories =
        <DarwinNotificationCategory>[
          DarwinNotificationCategory(
            darwinNotificationCategoryText,
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.text(
                'text_1',
                'Action 1',
                buttonTitle: 'Send',
                placeholder: 'Placeholder',
              ),
            ],
          ),
          DarwinNotificationCategory(
            darwinNotificationCategoryPlain,
            actions: <DarwinNotificationAction>[
              DarwinNotificationAction.plain('id_1', 'Action 1'),
              DarwinNotificationAction.plain(
                'id_2',
                'Action 2 (destructive)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.destructive,
                },
              ),
              DarwinNotificationAction.plain(
                navigationActionId,
                'Action 3 (foreground)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.foreground,
                },
              ),
              DarwinNotificationAction.plain(
                'id_4',
                'Action 4 (auth required)',
                options: <DarwinNotificationActionOption>{
                  DarwinNotificationActionOption.authenticationRequired,
                },
              ),
            ],
            options: <DarwinNotificationCategoryOption>{
              DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
            },
          ),
        ];

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
          notificationCategories: darwinNotificationCategories,
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await _createNotificationChannel();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: (_val) => );

    // _fcm.getToken().then((value) => log("FCM token value ----> $value"));
    // final prefs = await SharedPreferences.getInstance();
    // final isSubscribe = prefs.getBool(GlobalPrefsConst.isSubscribeNotify);
    // if (isSubscribe == null) {
    //   await _fcm.subscribeToTopic('All');
    // }

    _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    if (Platform.isIOS) {
      // _fcm
      //     .getToken()
      //     .then((value) => print('IOS FCM token value ----> $value'));
      // _fcm
      //     .getAPNSToken()
      //     .then((value) => print('IOS APNS token value ----> $value'));

      _fcm.requestPermission(announcement: true, criticalAlert: true);
    }
    FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);

    FirebaseMessaging.onMessage.listen((event) async {
      log('message $event');
      // _backgroundNotificationHandler(event);
      displayNotification(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      log('message $event');

      // if (event.data != null && event.data.isNotEmpty) {
      //   if (event.data['postId'] != null &&
      //       event.data['postId'].toString().isNotEmpty) {
      //   } else if (event.data['userId'] != null &&
      //       event.data['userId'].toString().isNotEmpty) {}
      // }
    });
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(
          'com.tezkyzmaty_sellers.app.urgent',
          'your channel name 2',
          description: 'your channel description 2',
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  void dispose() {
    iosSubscription.cancel();
    selectNotificationStream.close();
  }

  Future<void> onDidReceiveLocalNotification(
    int? id,
    String? title,
    String? body,
    String? payload,
  ) async {}

  Future<void> displayNotification(RemoteMessage event) async {
    log(event.data['key_2'].toString());
    await flutterLocalNotificationsPlugin.show(
      event.ttl ?? 0,
      event.notification?.title?.toString() ?? '',
      event.notification?.body ?? '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          icon: '@drawable/ic_notify_icon',
          color: TezColor.primary,
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        ),
      ),
      payload: event.data.toString(),
    );
  }
}

class ReceivedNotification {
  ReceivedNotification({this.id, this.title, this.body, this.payload});

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}

Future<void> backgroundNotificationHandler(RemoteMessage remoteMessage) async {}
