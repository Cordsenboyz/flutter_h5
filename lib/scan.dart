import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_scaffold.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  Future<void> GetStore(String? QRcodeValue) async {
    final dio = Dio();
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('Token')!;
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.get("https://localhost:7111/api/Store/Get?id=$QRcodeValue");
    debugPrint('${response}');
    if(response.statusCode == 200){
      
    } else {
      debugPrint('Something is not quite right');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "",
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            MobileScanner(
              // fit: BoxFit.contain,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  debugPrint('${barcode.rawValue}');
                  GetStore(barcode.rawValue);
                }
              },
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                child: Text(
                  "Scan QRcode i starten af butikken!", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 20.0,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,      // Choose the color of the shadow
                        blurRadius: 2.0,          // Adjust the blur radius for the shadow effect
                        offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
                      ),
                    ],
                  ),
                )
              )
            ),
          ]
        )
      )
    );
  }
}