import 'package:flutter/material.dart';
import 'common_drawer.dart';

class CustomScaffold extends StatelessWidget{
  final Widget body;
  final String appBarTitle;
  final CommonDrawer? drawer;


  const CustomScaffold({super.key, required this.body, required this.appBarTitle, this.drawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Color(0xff219EBC),
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
      ),
      body: body,
      endDrawer: drawer,
      bottomSheet: FractionallySizedBox(
        widthFactor: 100.0,
        heightFactor: 0.07,
        child: Container(alignment: Alignment.center, color: Color(0xff219EBC),)
      ),
    );
  }
}