import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concise/models/news_list_model.dart';
import 'package:concise/widgets/banner_news.dart';
import 'package:concise/widgets/list_news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsProvider with ChangeNotifier {

  static const newsToShow = 10;

  final Stream<QuerySnapshot> politicsStream = FirebaseFirestore.instance
      .collection('news/politics/political_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> entertainmentStream = FirebaseFirestore.instance
      .collection('news/entertainment/entertainment_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> financeStream = FirebaseFirestore.instance
      .collection('news/finance/finance_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> healthStream = FirebaseFirestore.instance
      .collection('news/health/health_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> internationalStream = FirebaseFirestore.instance
      .collection('news/international_affairs/international_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> sportsStream = FirebaseFirestore.instance
      .collection('news/sports/sports_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  final Stream<QuerySnapshot> techStream = FirebaseFirestore.instance
      .collection('news/tech_and_science/tech_and_science_news').where('newsNumber',isNotEqualTo: 0).limit(newsToShow)
      .orderBy('newsNumber',descending: true)
      .snapshots();

  StreamBuilder<QuerySnapshot> streamBuilder(Stream<QuerySnapshot<dynamic>>? newsStream,bool theme,BuildContext context){

    return StreamBuilder<QuerySnapshot>(
        stream: newsStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Whoops! Something went wrong"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color:Color(0xff1d425d)),
            );
          }
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            var banner;
            for (int i = 0; i < documents.length; i++) {
              if (documents[i]['isBanner'] == true &&
                  documents[i]['date'] ==
                      DateFormat('dd-MM-yyyy').format(DateTime.now())) {
                banner = documents[i];
                break;
              }
            }

            if(banner!=null) {
              documents.insert(0, banner);
              for(int i = 1; i<documents.length;i++){
                if(documents[i] == banner){
                  documents.removeAt(i);
                }
              }
            }

            return ListView.builder(
                itemCount:  documents.length,
                itemBuilder: (BuildContext context, index) {
                  if (index == 0) {
                    return NewsBanner(
                        NewsListModel.fromJson(documents[index].data() as Map<String, dynamic>),
                    theme);
                  } else {
                    return NewsList(NewsListModel.fromJson(
                        documents[index].data() as Map<String, dynamic>),
                    theme);
                  }
                });
          }
          return const SizedBox();
        });
  }

  }


