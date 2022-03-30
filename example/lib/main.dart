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
                  print('calling provision...');
                  try {
                    final result = await IdidFlutter.provision({
                      'derivationKey': '7A61136DA429FEFE16BC047615984F19',
                      'phoneNumber': '51996886684',
                      'documentId': '03543632043',
                      'issuerId': '1',
                      'track2': '5092670053401782=27056009171010000000',
                      'email': 'antonio.carvalho@paysmart.com.br',
                      'name': 'Antonio Gabriel de Carvalho',
                      // 'expirationDate': "2024-12-01",
                    });
                    print('provision result: $result');
                    setState(() {
                      _isProvisioned();
                    });
                  } on Exception catch (e) {
                    print('provision failed: $e');
                  } catch (error) {
                    print('provision failed: $error');
                  }
                },
              ),
              ElevatedButton(
                child: Text('AUTORIZAR!'),
                onPressed: () async {
                  print('calling authorize...');
                  try {
                    final result = await IdidFlutter.authorize({
                      "authorizationContent": json.encode({
                        "amount": 1.0,
                        "orderID": 13223,
                        "consumerID": 123844,
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
                    print('authorize result: $result');
                  } on Exception catch (e) {
                    print('authorize failed: $e');
                  } catch (error) {
                    print('authorize failed: $error');
                  }
                },
              ),
              ElevatedButton(
                child: Text('DESPROVISIONAR!'),
                onPressed: () async {
                  print('calling unProvision...');
                  try {
                    final result =
                        await IdidFlutter.unProvision({'issuerId': '1'});
                    print('unProvision result: $result');
                    setState(() {
                      _isProvisioned();
                    });
                  } on Exception catch (e) {
                    print('unProvision failed: $e');
                  } catch (error) {
                    print('unProvision failed: $error');
                  }
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
