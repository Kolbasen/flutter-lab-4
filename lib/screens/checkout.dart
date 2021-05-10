import 'dart:convert';
import 'package:dartz/dartz.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_lab_4/models/package_model.dart';
import 'package:http/http.dart' as http;

class CheckOutScreenArguments {
  final int carNumber;
  final int discount;

  CheckOutScreenArguments(this.carNumber, this.discount);
}

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isLoading = false;
  f.Option<PackageModel> packageResponse = f.None();

  void updateState() {}

  void checkOut(int carNumber, int discount) {
    setState(() {
      isLoading = true;
    });

    http
        .post(
          Uri.http('localhost:8000', 'checkout'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            <String, int>{'carNumber': carNumber, 'discount': discount},
          ),
        )
        .then(
          (response) => {
            setState(() {
              isLoading = false;
              packageResponse =
                  f.Some(PackageModel.parseJson(jsonDecode(response.body)));
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final CheckOutScreenArguments args =
        ModalRoute.of(context).settings.arguments as CheckOutScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? Text('Is loading...')
              : packageResponse.isSome()
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your order is ${packageResponse.getOrElse(() => null).status ? 'successful' : 'unsuccessful'}',
                        ),
                        Text(
                          'You can get your order in ${packageResponse.getOrElse(() => null).place} at ${packageResponse.getOrElse(() => null).date}',
                        ),
                        Text(
                          'Price with discount ${args.discount}% is ${packageResponse.getOrElse(() => null).price}',
                        ),
                      ],
                    )
                  : ElevatedButton(
                      child: Text(
                        'Get car ${args.carNumber} with ${args.discount}% discount',
                      ),
                      onPressed: () => checkOut(args.carNumber, args.discount),
                    ),
        ),
      ),
    );
  }
}
