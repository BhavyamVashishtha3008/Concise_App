import 'package:concise/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Entertainment extends StatefulWidget {
  static String routeName = '/Entertainment';
  bool theme;
  Entertainment(this.theme);
  @override
  State<Entertainment> createState() => _EntertainmentState();
}

class _EntertainmentState extends State<Entertainment> {
  @override
  Widget build(BuildContext context) {
    NewsProvider provider = Provider.of<NewsProvider>(context);
    return provider.streamBuilder(provider.entertainmentStream,widget.theme, context);
  }
}
