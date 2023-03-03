import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ContactUs extends StatelessWidget {
  bool theme;
  ContactUs(this.theme);
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle:
        SystemUiOverlayStyle(
          statusBarColor: theme?const Color(0xff22252e):const Color(0xff1d425d), // transparent status bar
        ),
        elevation: 1,
        title: Text(
          "Contact Us",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Poppins-Regular'),
        ),
        centerTitle: true,
        backgroundColor:theme?const Color(0xff22252e):const Color(0xff1d425d),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height/5,
          width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:theme?const Color(0xff22252e):const Color(0xff1d425d),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: const [
                   Icon(Icons.mail_outline,color: Colors.white,),
                   SizedBox(
                     width: 10,
                   ),
                   Text('official.conciseapp@gmail.com',style: TextStyle( fontSize: 15,
                       fontWeight: FontWeight.w500,
                       color: Colors.white70,
                       fontFamily: 'Poppins-Regular'),),
                 ],
               ),
             ),
          ],
        ),
      ),
    );
  }
}
