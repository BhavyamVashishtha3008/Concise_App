import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicy extends StatefulWidget {
  // const PrivacyPolicy({Key? key}) : super(key: key);
  bool theme;
  PrivacyPolicy(this.theme);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String data='';
  fetchFileData() async{
    String responseText;
    responseText=await rootBundle.loadString('assets/text/Privacy Policy.txt');

    setState(() {
      data=responseText;
    });

  }
  @override
  void initState() {
     fetchFileData();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
        SystemUiOverlayStyle(
          statusBarColor: widget.theme?Color(0xff22252e):Color(0xff1d425d), // transparent status bar
        ),
        backgroundColor: widget.theme?Color(0xff22252e):Color(0xff1d425d),

        elevation: 1,
        title: Text(
          "Privacy",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 40,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontFamily: 'Poppins-Regular'),
        ),
        centerTitle: true,

      ),

      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(children: [
          Text(data,style: TextStyle(color: Colors.black54),),
    ],

        ),
      ),
    );
  }
}
