
import 'package:flutter/material.dart';

import 'custom_scaffold.dart';
import 'main.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "",
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Register", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Brugernavn",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                ),
              ),
              const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Kodeord",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 20,),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Telefon",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                child: const Text("Opret"),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const App()),
                  );
              }),
            ]
          ),
        )
      )
    );
  }
}