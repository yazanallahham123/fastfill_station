import 'dart:convert';
import 'dart:io';

import 'package:fastfill_station_app/model/notification/notification_body.dart';
import 'package:fastfill_station_app/ui/home/home_page.dart';
import 'package:fastfill_station_app/ui/home/new_transactions_tab_page.dart';
import 'package:fastfill_station_app/ui/language/language_page.dart';
import 'package:fastfill_station_app/utils/local_data.dart';
import 'package:fastfill_station_app/utils/misc.dart';
import 'package:fastfill_station_app/utils/notifications.dart';
import 'package:fastfill_station_app/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:logger/logger.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'helper/app_colors.dart';
import 'helper/methods.dart';
import 'firebase_options.dart';
import 'helper/toast.dart';
import 'model/user/user.dart';


final logger = Logger();
bool isSigned=false;
String languageCode = "en";
int languageId = 2;
User? currentUser = null;

int downloadOption = 0;
int homePageIndex = 0;
bool downloadMode = false;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool showSignupInStationApp = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
  );

  notifications.init();
  
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'ar']);

  currentUser = await getCurrentUserValue();

  if (currentUser != null)
    if (currentUser?.id != null)
      if (currentUser?.id != 0)
        isSigned = true;

  getLanguage().then((l) {
      if (l.isNotEmpty)
      {
        languageCode = l;
      }
  });

  runApp(LocalizedApp(delegate, FastFillStationApp()));
}

class FastFillStationApp extends StatefulWidget {
  @override
  _FastFillStationApp createState() => _FastFillStationApp();

  static void setLocale(BuildContext context, Locale newLocale) async {
    _FastFillStationApp? state = context.findAncestorStateOfType<_FastFillStationApp>();
    state?.changeLanguage(newLocale);
  }

  static Locale? getLocale(BuildContext context) {
    _FastFillStationApp? state = context.findAncestorStateOfType<_FastFillStationApp>();
    return state?.getLanguageFromLocale();
  }

//static _FastFillApp? of(BuildContext context) => context.findAncestorStateOfType<_FastFillApp>();
}


Future<void> showNotification(Map<String, dynamic> downloadStatus) async {
  final androidNotificationDetails = AndroidNotificationDetails(
      'channel id',
      'channel name',
      priority: Priority.high,
      importance: Importance.max
  );
  final iOSNotificationDetails = DarwinNotificationDetails();
  final platform = NotificationDetails(android: androidNotificationDetails, iOS: iOSNotificationDetails);
  final json = jsonEncode(downloadStatus);
  final isSuccess = downloadStatus['isSuccess'];

  await flutterLocalNotificationsPlugin.show(
      0, // notification id
      isSuccess ? translate("labels.success") : translate("labels.fail"),
      isSuccess ? translate("messages.successFileDownload") : translate("messages.failFileDownload"),
      platform,
      payload: json
  );
}


class _FastFillStationApp extends State<FastFillStationApp> with WidgetsBindingObserver {
  Locale _locale = Locale.fromSubtags(languageCode: languageCode);

  Future<void> _onSelectNotification(String? json) async {
    final obj = jsonDecode(json!);

    if (obj['isSuccess']) {
      Uri uri = Uri.file(obj['filePath']);
      if (!File(uri.toFilePath()).existsSync()) {
        pushToast("File doesn't exists");
      }

      OpenFilex.open(uri.toFilePath());
      //if (!await launchUrl(uri)) {
        //pushToast("Could not open file");
      //}
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }

  @override
  void initState() {


    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOSSettings = DarwinInitializationSettings();
    final initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      if (notificationResponse.notificationResponseType == NotificationResponseType.selectedNotification)
        {
          _onSelectNotification(notificationResponse.payload);
          print("notification is selected");
        }
      else {
        if (notificationResponse.notificationResponseType ==
            NotificationResponseType.selectedNotificationAction) {
          _onSelectNotification(notificationResponse.payload);
          print("notification is selected action");
        }
      }
    }
    );




    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      {
        print("app state is resumed");
        //NotificationBody n = NotificationBody(typeId: "1");
        //notificationsController.sink.add(n);
      }
  }

  changeLanguage(Locale value) {
    if (mounted) {
      setState(() {
        _locale = value;
      });
    }
  }

  Locale getLanguageFromLocale()
  {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUserValue().then((v) {
      if (v != null)
        if (v.id != null)
          if (v.id != 0)
            isSigned = true;
    });

    getLanguage().then((l) {
      if (l != null) {
        if (l.isNotEmpty)
        {
          languageCode = l;
        }
      }
    });

    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: DismissKeyboard(child: GetMaterialApp(
          title: 'Fast Fill Station',
          onGenerateInitialRoutes:
              (String initialRouteName) {
            return [
              AppRouter.generateRoute(RouteSettings(name:
              (isSigned) ? HomePage.route : LanguagePage.route,
                  arguments: null
              ))
            ];
          },
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            localizationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: _locale,
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: backgroundColor1,
                    statusBarBrightness: Brightness.light,
                    statusBarIconBrightness: Brightness.light,
                  )
              ),
              primaryColor: primaryColor1,
              accentColor: primaryColor2,
              fontFamily: isArabic() ? 'Poppins' : 'Poppins'),
          initialRoute: (isSigned) ? HomePage.route : LanguagePage.route,
        )));
  }
}
