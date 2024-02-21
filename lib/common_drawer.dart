import 'package:flutter/material.dart';
import 'package:flutter_h5/main.dart';
import 'home.dart';

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
            ListTile(
              title: const Text('Home'),
              onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
              },
            ), 
            ListTile(
              title: const Text("Log Ud"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const App()));
              }
            )
        ],
      ),
    );
  }
}