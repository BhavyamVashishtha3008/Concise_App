//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:concise/models/news_list_model.dart';
// import 'package:concise/providers/news_provider.dart';
// import 'package:concise/widgets/banner_news.dart';
// import 'package:concise/widgets/list_news.dart';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// class Miscellaneous extends StatefulWidget {
//
//   static String routeName='/Miscellaneous';
//   @override
//   State<Miscellaneous> createState() => _MiscellaneousState();
// }
//
// class _MiscellaneousState extends State<Miscellaneous> {
//
//   @override
//   Widget build(BuildContext context) {
//     NewsProvider provider = Provider.of<NewsProvider>(context);
//     return StreamBuilder<QuerySnapshot>(
//         stream: provider.miscellaneousStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text("Whoops! Something went wrong"),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(color:Color(0xff1d425d)),
//             );
//           }
//           if (snapshot.hasData) {
//             final List<DocumentSnapshot> documents = snapshot.data!.docs;
//
//             var banner;
//             for (int i = 0; i < documents.length; i++) {
//               if (documents[i]['isBanner'] == true) {
//                 banner = documents[i];
//                 break;
//               }
//             }
//
//             if(banner!=null) {
//               documents.insert(0, banner);
//               for(int i = 1; i<documents.length;i++){
//                 if(documents[i] == banner){
//                   documents.removeAt(i);
//                 }
//               }
//             }
//             return ListView.builder(
//                 itemCount:  documents.length<provider.newsToShow ? documents.length : provider.newsToShow,
//                 itemBuilder: (BuildContext context, index) {
//                   if (index == 0) {
//                     return NewsBanner(
//                         NewsListModel.fromJson(documents[index].data() as Map<String, dynamic>));
//                   } else {
//                     return NewsList(NewsListModel.fromJson(
//                         documents[index].data() as Map<String, dynamic>));
//                   }
//                 });
//           }
//           return SizedBox();
//         });
//   }
// }
