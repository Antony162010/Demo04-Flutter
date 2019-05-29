import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:Biconik/screens/ProductScreen.dart';
import 'package:Biconik/widgets/button_buy.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data;
  List productsData;
  // Config config;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: productsData == null ? 0 : productsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                // verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(productsData[index]['image']['url']),
                    maxRadius: 50,
                  ),
                  Container(
                    width: 140,
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "${productsData[index]['name']}",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'stock:'
                            "${productsData[index]['quantity']}",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: ButtonPersonal('Comprar'),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    splashColor: Colors.purple[900],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductPage(
                                id: productsData[index]['_id'],
                                img: productsData[index]['image']['url'],
                                descrip: productsData[index]['description'],
                                price: productsData[index]['price']
                                )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  getProducts() async {
    http.Response response =
        await http.get('http://178.128.14.222/BackMEAN/api/products');
    data = json.decode(response.body);
    setState(() {
      productsData = data['products'];
    });
  }
}
