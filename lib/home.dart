import 'package:flutter_h5/common_drawer.dart';
import 'package:flutter_h5/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_h5/scan.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Home",
      drawer: CommonDrawer(),
      body: Center(
        child: Padding(padding: const EdgeInsets.only(left: 30.0, top: 30.0, bottom: 70.0, right: 30.0),
          child: Column(
            children: <Widget>[
              Align(alignment: FractionalOffset.center,
                child: SizedBox(
                  width: double.infinity,
                  height: 100.0,
                  child: ElevatedButton(
                    child: const Text("Start"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8ECAE6),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Scan()),
                      );
                    },
                  )
                )
              ),
              Expanded(child: SizedBox()),
              Align(alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    child: const Text("Kviteringer"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8ECAE6),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {

                    },
                  )
                )
              ),
            ],
          )
        )
      )
    );
  }
}