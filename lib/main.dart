import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:concise/providers/concise_api.dart';
import 'package:concise/providers/news_provider.dart';
import 'package:concise/providers/theme.dart';
import 'package:concise/screens/Home%20Screens/Entertainment.dart';
import 'package:concise/screens/Home%20Screens/Finance.dart';
import 'package:concise/screens/Home%20Screens/Health.dart';
import 'package:concise/screens/Home%20Screens/InternationalAffairs.dart';
import 'package:concise/screens/Home%20Screens/Politics.dart';
import 'package:concise/screens/Home%20Screens/Sports.dart';
import 'package:concise/screens/Home%20Screens/Tech&Science.dart';
import 'package:concise/screens/Home%20Screens/live_news.dart';
import 'package:concise/screens/Loading%20Screen/tabs_screen.dart';
import 'package:concise/screens/Loading%20Screen/splash.dart';
import 'package:concise/widgets/web_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Basic',
        channelDescription: 'First Notif',
    importance: NotificationImportance.Max,
    enableLights: true,
    ledColor: const Color(0xff1d425d),
    enableVibration: true,
    playSound: true)
  ]);
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
  SystemChrome.setSystemUIOverlayStyle((const SystemUiOverlayStyle(
    statusBarColor: Color(0xff1d425d), // transparent status bar
  )));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: NewsProvider(),
      ),
      ChangeNotifierProvider.value(
        value: ConciseApi(),
      ),
      ChangeNotifierProvider.value(
        value: ChangeTheme(),
      ),
    ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Concise',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Scaffold(
            body: SplashScreen(),
          ),
          routes: {
            Web.routeName: (ctx) => Web("", false),
            // AppDrawer.routeName:(ctx)=>AppDrawer(),
            Entertainment.routeName:(ctx)=>Entertainment(false),
            Politics.routeName:(ctx)=>Politics(false),
            Finance.routeName:(ctx)=>Finance(false),
            Sports.routeName:(ctx)=>Sports(false),
            TechScience.routeName:(ctx)=>TechScience(false),
            International.routeName:(ctx)=>International(false),
            Health.routeName:(ctx)=>Health(false),
            TabsScreen.routeName:(ctx)=>TabsScreen(),
            LiveNews.route:(ctx)=>LiveNews(),
          },
        ),
      ),
    );
  }
}
