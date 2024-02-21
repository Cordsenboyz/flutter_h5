import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_scaffold.dart';
import 'home.dart';
import 'register.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indkøbskassen',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xffF6F6F6)),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final dio = Dio();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> Login() async {
    var formData = FormData.fromMap({
      'data': jsonEncode(
        {
          'email': _emailController.text,
          'password': _passwordController.text
        }
      )
    });
    dio.options.headers = {
      'Content-Type': 'application/json;charset=UTF-8'
    };
    final response = await dio.post("https://localhost:7111/api/Auth/Login", 
      data: {'email': _emailController.text, 'password': _passwordController.text});

    if(response.statusCode == 200){
      Map<String, dynamic> responseData = response.data;
      final pref = await SharedPreferences.getInstance();
      pref.setString('Token', responseData['token']['token']);

      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  } 

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
              const Image(image: AssetImage('assets/h5appLogo.jpg')),
              const SizedBox(height: 50,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: "Kodeord",
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10,),
              TextButton(onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              }, child: const Text("Register")),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Login"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff8ECAE6),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Login()
                )
              ),
              const SizedBox(height: 100,),
            ]
          )
        )
      ),
    );
  }
}
