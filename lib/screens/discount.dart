import 'package:flutter/animation.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class DiscountScreen extends StatefulWidget {
  final int carNumber;

  DiscountScreen({@required this.carNumber});
  @override
  _DiscountScreenState createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _offsetAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int getRandomNumber() {
    Random random = new Random();
    int randomNumber = random.nextInt(31);
    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SlideTransition(
                position: _offsetAnimation,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FlutterLogo(size: 150.0),
                ),
              ),
            ),
            ElevatedButton(
              child:
                  Text('Get discount for car ${widget.carNumber.toString()}'),
              onPressed: () {
                Navigator.pop(context, getRandomNumber());
              },
            )
          ],
        ),
      ),
    );
  }
}
