import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:concise/providers/concise_api.dart';
import 'package:concise/widgets/web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO: A Temporary Solution-----------------------------------------------------------

int newsIndex = 0;
void Notify(BuildContext context, int index) async {
  if(newsIndex>30){
    newsIndex = 0;
  }

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(40),
          channelKey: 'key1',
          body:latestNews[newsIndex].listItemHeadLine,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: latestNews[index].listItemImageUrl,
          payload: {'link': latestNews[index].listItemNewsLink}));

  try {
    AwesomeNotifications().actionStream.listen((recievedNotification) async {
      try {
        var link = recievedNotification.payload!.values.toList();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => Web(link[0], false)));
      } catch (e) {//print('Null;))
        }
    });
  } catch (e) {
   // print("Removing extra Stream");
  }
  newsIndex++;
}
