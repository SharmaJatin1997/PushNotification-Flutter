import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:push_notification/NotificationEntity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'Utils/shared_prefrence_helper.dart';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();
  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );


  final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _configureSelectNotificationSubject();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectNotificationSubject.add(payload);
    });

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    final _firebaseMessaging = FirebaseMessaging.instance;
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    initFirebaseListeners();
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      if (SharedPreferenceHelper().getUserToken() == null) {
        return;
      }
      NotificationEntity? entity = SharedPreferenceHelper().convertStringToNotificationEntity(payload);
      debugPrint("notification _configureSelectNotificationSubject ${entity?.toJson()}");
      if (entity != null) {
        pushNextScreenFromForeground(entity);
      }
    });
  }

  Future? onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    if (SharedPreferenceHelper().getUserToken() == null) {
      return null;
    }
    NotificationEntity? entity = SharedPreferenceHelper().convertStringToNotificationEntity(payload);
    debugPrint("notification onDidReceiveLocalNotification ${entity.toString()}");
    if (entity != null) {
      pushNextScreenFromForeground(entity);
    }
    return null;
  }

  void initFirebaseListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (SharedPreferenceHelper().getUserToken() == null) {
        debugPrint("userToken is Null");
        return;
      }
      debugPrint("Foreground notification opened ${message.data}");
      NotificationEntity notificationEntity = NotificationEntity.fromJson(message.data);
      if (notificationEntity.msgData == SharedPreferenceHelper().getActiveChatId().toString()) {
        debugPrint("active chat id => ${SharedPreferenceHelper().getActiveChatId()} is same");
        return;
      }
      pushNextScreenFromForeground(notificationEntity);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (GetPlatform.isIOS || SharedPreferenceHelper().getUserToken() == null) {
        return;
      }
      debugPrint("Foreground notification received  ${message.data}");
      NotificationEntity notificationEntity = NotificationEntity.fromJson(message.data);
      debugPrint(message.data.toString());
      notificationEntity.title = "SponPlan";
      notificationEntity.body = notificationEntity.body;
      debugPrint("hellooo--->> Displaying Notification");
      showNotifications(notificationEntity);
    });
  }

  Future? onSelectNotification(String? payload) {
    if (SharedPreferenceHelper().getUserToken() == null) {
      return null;
    }
    NotificationEntity? entity = SharedPreferenceHelper().convertStringToNotificationEntity(payload);
    debugPrint("notification onSelectNotification ${entity.toString()}");
    if (entity != null) {
      pushNextScreenFromForeground(entity);
    }
    return null;
  }

  Future<void> showNotifications(NotificationEntity notificationEntity) async {
    /**for chatting*/

    // if (Get.currentRoute == Routes.singleChat) {
    //   return;
    // }

    Random random = Random();
    int id = random.nextInt(900) + 10;
    await flutterLocalNotificationsPlugin.show(
        id,
        notificationEntity.title,
        notificationEntity.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: "@mipmap/ic_launcher",
            channelShowBadge: true,
            playSound: true,
            priority: Priority.high,
            importance: Importance.high,
            styleInformation: BigTextStyleInformation(notificationEntity.body ?? ""),
          ),
        ),
        payload: SharedPreferenceHelper().convertNotificationEntityToString(notificationEntity));
  }

  void pushNextScreenFromForeground(NotificationEntity notificationEntity) async {
    // Utils.showLoader();
    Tuple2<String, Object?>? tuple2 = await callApi(notificationEntity,0);
    // await Utils.hideLoader();
    debugPrint("current active screen ${Get.currentRoute}");
    if (tuple2 != null) {

      // if(Get.currentRoute == Routes.home && notificationEntity.notification_type=="7"){
      //   debugPrint("--------------------opene"   );
      //     if(Get.isRegistered<HomeScreenController>()){
      //       Get.find<HomeScreenController>().getOpponentProfileNew(int.parse(notificationEntity.senderId??""));
      //       }

      } else {
        debugPrint("--------------------back");
    }
  }

  Future<Tuple2<String, Object?>?> callApi(NotificationEntity entity,int type) async {
    print("notification ${entity.notification_type}");
    switch (entity.notification_type) {

      /**Create case as per your code*/

      // case "1":
        // return Tuple2<String, Object?>(Routes.notifications, type);
      // case "2":
        // Map<String, int> queries = HashMap();
        // queries["id"] = int.parse(entity.senderId!);
        // queries["type"] = type;
        // return Tuple2<String, Object?>(Routes.singleChat,queries);


        // return Tuple2<String, Object?>(Routes.notifications, type);
      // case "3":

        // Map<String, int> queries = HashMap();
        // queries["id"] = int.parse(entity.senderId!);
        // queries["type"] = type;
        // return Tuple2<String, Object?>(Routes.singleChat,queries);
    }
  }

  Future<Tuple2<String, Object?>?> getPushNotificationRoute() async{
    RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
   // final NotificationAppLaunchDetails? notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final NotificationAppLaunchDetails? notificationAppLaunchDetails = null;

    NotificationEntity? entity;
    if (remoteMessage != null && remoteMessage.data.isNotEmpty) {
      debugPrint("RemoteMessage data${remoteMessage.data}");
      NotificationEntity notificationEntity = NotificationEntity.fromJson(remoteMessage.data);
      entity = NotificationEntity();
      entity.body = remoteMessage.data['body'];
      entity.user_id = remoteMessage.data['user_id'];
      entity.senderId = remoteMessage.data['senderId'];
      entity.receiverId = remoteMessage.data['receiverId'];
      entity.title = remoteMessage.data['title'];
      entity.notification_type = remoteMessage.data['notification_type'];
      entity.senderName = remoteMessage.data['senderName'];
      return await callApi(notificationEntity,1);
    } else if (notificationAppLaunchDetails != null && notificationAppLaunchDetails.didNotificationLaunchApp == true) {
      NotificationEntity? entity = SharedPreferenceHelper().convertStringToNotificationEntity(notificationAppLaunchDetails.payload);
      if(entity != null) {
        debugPrint("RemoteMessage data${entity.toJson()}");
        return await callApi(entity,1);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

}
