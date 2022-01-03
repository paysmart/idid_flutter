import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idid_flutter/idid_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<dynamic> isProvisioned;

  @override
  void initState() {
    super.initState();
    _isProvisioned();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: isProvisioned,
                initialData: false,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(fontSize: 16),
                  );
                },
              ),
              ElevatedButton(
                child: Text('PROVISIONAR!'),
                onPressed: () async {
                  print('AAAAAAAAAAAAAAAAAAA: ${await IdidFlutter.provision({
                    'issuerId': '123123',
                    'documentId': '03543632043',
                    'phoneNumber': '51996886684',
                    'email': 'antonio.carvalho@paysmart.com.br',
                    'name': 'Antonio Gabriel de Carvalho',
                    'derivationKey': 'AAAAAAAAAAAAAAAACCCCCCCCCCCCCCCC',
                    'expirationDate': "2024-12-01",
                    'track2': '5092573092570005=24126004081010000000'
                  })}');
                },
              ),
              ElevatedButton(
                child: Text('AUTORIZAR!'),
                onPressed: () {
                  IdidFlutter.authorize({
                    "authorizationContent": json.encode({
                      "amount": 1.0,
                      "orderID": 13223,
                      "consumerID": 123807,
                      "installmentPrice": 1.0,
                      "version": "1.0.1",
                      "transactionID": 13171,
                      "products": [
                        {
                          "quantity": 1,
                          "description": "Teclado Gamer C3",
                          "unityPrice": 1.0,
                          "sku": 3333
                        }
                      ],
                      "nomeDoComercio": "MUXI",
                      "issuerID": 123123,
                      "totalInstallments": 1,
                      "merchantID": 11111,
                      "countryCode": "076",
                      "cardID": 123824,
                      "merchantTxID": 11111,
                      "text": "TESTE",
                      "acquirerID": 1,
                      "currencyCode": "BRL"
                    })
                  });
                },
              ),
              ElevatedButton(
                child: Text('DESPROVISIONAR!'),
                onPressed: () {
                  IdidFlutter.unProvision({'issuerId': '123123'});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _isProvisioned() => isProvisioned = IdidFlutter.isProvisioned();
}
