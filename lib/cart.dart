import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_scaffold.dart';

class Store {
  String Id;
  String name;

  Store(this.Id, this.name);
}

class Item {
  String id;
  String name;

  Item(this.id, this.name);
}

class Cart extends StatefulWidget {
  final Store store;

  const Cart({super.key, required this.store});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final List<Item> items = [];

  Future<Map<String, dynamic>> GetStore(String? QRcodeValue) async {
    final dio = Dio();
    var pref = await SharedPreferences.getInstance();
    var token = pref.getString('Token')!;
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.get("https://localhost:7111/api/Goods/Get?id=$QRcodeValue");
      Map<String, dynamic> responseData = response.data;
      return responseData;
  }

  _showSimpleModalDialog(context){
    String? oldValue = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(20.0)),
            child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: MobileScanner(
                // fit: BoxFit.contain,
                onDetect: (capture) async {
                  final List<Barcode> barcodes = capture.barcodes;
                  final Uint8List? image = capture.image;
                  for (final barcode in barcodes) {
                    if(oldValue != barcode.rawValue){
                      var response = await GetStore(barcode.rawValue);

                      Item item = Item(response["id"], response["name"]);

                      setState(() {
                        items.add(item);
                      });

                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: widget.store.name,
      body: Padding(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0, bottom: 80.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            CustomScrollView(
              slivers: [SliverList.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index)
                {
                  final item = items[index];
              
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(image: AssetImage('assets/h5appLogo.jpg'),fit: BoxFit.fill)
                    ),
                    child: Text(item.name),
                  );
                }
              ),]
            ),
            ElevatedButton(
              onPressed: () => _showSimpleModalDialog(context), 
              child: const Text("Scan Vare")
            ),
            ElevatedButton(
              onPressed: () => (), 
              child: const Text("Betal")
            )
          ],
        )
      )
    );
  }
}