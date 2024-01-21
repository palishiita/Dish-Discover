import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final bool buyingPremium;
  const PaymentPage({super.key, required this.buyingPremium});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Buy ${buyingPremium ? 'Premium' : 'recipe boost'}'),
          centerTitle: true),
      body: const Placeholder(child: Center(child: Text('PayPal WebView'))),
    );
  }
}
