
import 'package:concise/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notification/notification_api.dart';
import 'live_news.dart';

class Health extends StatefulWidget {
  static String routeName='/Health';
  bool theme;
  Health(this.theme);
  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {



  @override
  Widget build(BuildContext context) {

    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.healthStream,widget.theme, context);
  }
}