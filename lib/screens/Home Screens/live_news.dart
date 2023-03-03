import 'package:concise/models/push_notification_model.dart';
import 'package:concise/providers/concise_api.dart';
import 'package:concise/providers/theme.dart';
import 'package:concise/screens/Home%20Screens/live_news_list.dart';
import 'package:concise/screens/Loading%20Screen/app_drawer.dart';
import 'package:concise/screens/Loading%20Screen/tabs_screen.dart';
import 'package:concise/widgets/app_display.dart';
import 'package:concise/widgets/notification_badge.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class LiveNews extends StatefulWidget {
  static String route = '/live';

  @override
  _LiveNewsState createState() => _LiveNewsState();
}

class _LiveNewsState extends State<LiveNews> {
  var subscription;
  var connectionStatus;

  late final FirebaseMessaging _messaging;

  PushNotication? _notificationInfo;
  var now = DateTime.now();

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;
    await Firebase.initializeApp();

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      //  print("User granted permission");

      FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) {
          PushNotication notification = PushNotication(
            message.notification!.title as String,
            message.notification!.body as String,
          );
          setState(() {
            _notificationInfo = notification;
          });

          if (notification != null) {
            showSimpleNotification(
              Text(_notificationInfo!.title),
              leading: NotificationBadge(),
              subtitle: Text(_notificationInfo!.body),
              background: Colors.cyan.shade700,
              duration: const Duration(seconds: 2),
            );
          }
        },
      );
    } else {
      // print("permission denied");
    }
  }

  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotication notification = PushNotication(
        initialMessage.notification!.title as String,
        initialMessage.notification!.body as String,
      );

      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds:0),(){
      Provider.of<ChangeTheme>(context).loadData();
    });
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => connectionStatus = result);
      checkInternetConnectivity();
    });

//   when app is is background

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotication notification = PushNotication(
        message.notification!.title as String,
        message.notification!.body as String,
      );
      setState(() {
        _notificationInfo = notification;
      });
    });

// normal notification in foreground state i.e app is running

    registerNotification();

// when app is in terminated state

    checkForInitialMessage();

    super.initState();
  }

  int selectedPageIndex = 0;
  final ScrollController _controller = ScrollController();

  final double _height = 100.0;

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
  int isSelected=0;
  // var date = DateTime.now();
  double i = 50;

  final PageController _pageController = PageController(initialPage: 0);

  checkInternetConnectivity() {
    if (connectionStatus == ConnectivityResult.none) {
      return Fluttertoast.showToast(
          msg: "Check your internet connection",
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.white54,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<ChangeTheme>(context);
    bool theme= prov.theme;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor:theme ? const Color(0xff22252e):const Color(0xff1d425d), // transparent status bar
        ),
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
           const AppDisplay(),
          ],
          body: Stack(
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: theme? const Color(0xff22252e):const Color(0xff1d425d),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration:BoxDecoration(
                      color:  theme?const Color(0xff14191e):Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 27,
                          left: 14,
                          right: 14,
                          bottom: 14
                      ),
                      child: PageView(
                          controller: _pageController,
                          onPageChanged: (newIndex) {
                            setState(() {
                              _animateToIndex(newIndex);
                              selectedPageIndex = newIndex;
                            });
                          },
                        children: [LiveNewsList(theme)],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 100,
                right: 100,
                child: Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: 180,
                  decoration:BoxDecoration(
                      color: theme ? Colors.black54: const Color(0xff03253e),
                      borderRadius:const BorderRadius.all(Radius.circular(10))
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(onPressed: (){

                          Navigator.of(context).pop(context);
                        },
                            child:const Text('Summary',
                              style: TextStyle(
                                  shadows: [Shadow(offset: Offset(0, -6), color: Colors.white)],
                                  fontSize: 24,color: Colors.transparent,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins-Regular'),)
                        ),

                        const Text('|',
                          style: TextStyle(shadows: [Shadow(offset: Offset(0, -7), color: Colors.white)],fontSize:30,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Poppins-Regular'),),
                        FlatButton(onPressed: (){
                        },
                          child:const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Live News',
                              style: TextStyle(
                                  fontSize:24,
                                  color: Colors.transparent,
                                  fontWeight: FontWeight.w400,
                                  shadows: [Shadow(offset: Offset(0, -5), color: Colors.white)],
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  decorationThickness: 3,
                                  fontFamily: 'Poppins-Regular'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(prov.theme),
    );
  }
}
