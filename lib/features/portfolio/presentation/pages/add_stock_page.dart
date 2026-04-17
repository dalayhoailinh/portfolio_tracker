import 'package:flutter/material.dart';

class AddStockPage extends StatelessWidget {
  const AddStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Stock')),
      body: const Center(child: Text('Add Stock Page')),
    );
  }
}
