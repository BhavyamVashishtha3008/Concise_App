import 'package:concise/notification/notification_api.dart';
import 'package:concise/providers/concise_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/news_provider.dart';


class Politics extends StatefulWidget {
  static String routeName = '/Politics';
  bool theme;

  Politics(this.theme);

  @override
  State<Politics> createState() => _PoliticsState();
}

class _PoliticsState extends State<Politics> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
     return provider.streamBuilder(provider.politicsStream,widget.theme, context);
  }
}
