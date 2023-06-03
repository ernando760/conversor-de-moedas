import 'package:conversor_de_moedas/src/pages/controllers/currency_controller.dart';
import 'package:conversor_de_moedas/src/repositories/currency_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currencyController = CurrencyController(CurrencyRepositoryImpl());
  @override
  void initState() {
    super.initState();
    Future.value(currencyController.convertCurrency(
        code: "USD", codein: "BRL", value: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de moedas'),
      ),
      body: const Column(
        children: [
          // DropdownButton<String>(
          //     value: "USD",
          //     items: const [
          //       DropdownMenuItem(
          //         value: "BRL",
          //         child: Text("USD"),
          //       ),
          //       DropdownMenuItem(
          //         value: "BRL",
          //         child: Text("BRL"),
          //       ),
          //       DropdownMenuItem(
          //         value: "BRL",
          //         child: Text("USD"),
          //       ),
          //     ],
          //     onChanged: (value) {})
        ],
      ),
    );
  }
}
