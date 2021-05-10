import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lab_4/screens/checkout.dart';
import 'package:flutter_lab_4/screens/discount.dart';

class HomeScreen extends StatefulWidget {
  final Function onThemeSwitch;
  HomeScreen({@required this.onThemeSwitch});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int discount = 0;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
  }

  Future<void> getDiscount(carNumber) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscountScreen(carNumber: carNumber),
      ),
    );
    setState(() {
      discount = result;
    });
  }

  void redirectToCheckout(carNumber) {
    Navigator.pushNamed(
      context,
      '/checkout',
      arguments: CheckOutScreenArguments(carNumber, discount),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: [
          IconButton(
            icon: Icon(Icons.accessible_forward_sharp),
            onPressed: widget.onThemeSwitch,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 160),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ElevatedButton(
                        child: Text('Get discount 1'),
                        onPressed: () => getDiscount(1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ElevatedButton(
                        child: Text('Get discount 2'),
                        onPressed: () => getDiscount(2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: ElevatedButton(
                        child: Text('Get discount 3'),
                        onPressed: () => getDiscount(3),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: animation.value,
                        height: animation.value,
                        child: ElevatedButton(
                          child: Text('Get car 1'),
                          onPressed: () => redirectToCheckout(1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: animation.value,
                        height: animation.value,
                        child: ElevatedButton(
                          child: Text('Get car 2'),
                          onPressed: () => redirectToCheckout(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: animation.value,
                        height: animation.value,
                        child: ElevatedButton(
                          child: Text('Get car 3'),
                          onPressed: () => redirectToCheckout(3),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
