import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yatra/core/utils/route_generator.dart';
import 'package:yatra/core/utils/routes.dart';
import 'package:yatra/features/add_place/bloc/add_place_bloc.dart';
import 'package:yatra/features/add_place/pages/add_places.dart';
import 'package:yatra/features/auth/bloc/auth_bloc.dart';
import 'package:yatra/features/auth/pages/login_page.dart';
import 'package:yatra/features/auth/pages/signup_page.dart';
import 'package:yatra/features/auth/pages/signup_page1.dart';
import 'package:yatra/features/splash_screen/onboarding_page.dart';
import 'package:yatra/features/splash_screen/splash_screen.dart';
import 'package:yatra/features/test/google_login_page.dart';
import 'package:yatra/features/test/test_bloc.dart';
import 'package:yatra/features/test/test_of_bloc.dart';
import 'package:yatra/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    checkPermission();
    initializeLocalNotification();
    getFcmToken();
    readValueFromNotification();

    super.initState();
  }

  void checkPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  getFcmToken() async {
    String? token = await messaging.getToken();
    print("token is ${token}");
  }

  readValueFromNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showSimpleNotification(
        message.notification?.title ?? "",
        message.notification?.body ?? "",
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState?.pushNamed(
        Routes.notificationsRoute,
        arguments: NotificationsPayLoad(
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  initializeLocalNotification() {
    var initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final data = jsonDecode(details.payload!);

        navigatorKey.currentState?.pushNamed(
          Routes.notificationsRoute,
          arguments: NotificationsPayLoad(
            title: data["title"],
            body: data["body"],
          ),
        );
      },
    );
  }

  void showSimpleNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode({"title": title, "body": body}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<PasswordBloc>(create: (context) => PasswordBloc()),
        BlocProvider<AddPlacesBloc>(create: (context) => AddPlacesBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AddPlacesScreen(),
      ),
    );
  }
}

class NotificationsPayLoad {
  String? title;
  String? body;

  NotificationsPayLoad({this.title, this.body});
}
