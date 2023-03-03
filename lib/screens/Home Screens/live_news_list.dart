import 'package:concise/providers/concise_api.dart';
import 'package:concise/widgets/banner_news.dart';
import 'package:concise/widgets/list_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../notification/notification_api.dart';
import '../../providers/concise_api.dart';

class LiveNewsList extends StatefulWidget {

  bool theme;
  LiveNewsList(this.theme);

  @override
  _LiveNewsState createState() => _LiveNewsState();
}
class _LiveNewsState extends State<LiveNewsList> {

  Future<void> refreshNews(BuildContext context)async {
    await Provider.of<ConciseApi>(context).getLatestNews();
  }

    @override
    Widget build(BuildContext context) {

    Provider.of<ConciseApi>(context).liveNews();

    return RefreshIndicator(
      onRefresh: () async { await refreshNews(context);setState(() {
      });},
      child: latestNews.isEmpty? Center(child: const CircularProgressIndicator()):ListView.builder(itemCount:latestNews.length,itemBuilder: (context, index) {
             return   index % 4 == 0 ? NewsBanner(latestNews[index], widget.theme) : NewsList(latestNews[index], widget.theme);
           }),
    );
  }
}