import 'dart:async';
import 'dart:developer';

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
  final deboucer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    Future(() => currencyController.convertCurrency(
        code: "USD", codein: "BRL", value: "1"));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de moedas'),
      ),
      body: AnimatedBuilder(
          animation: currencyController,
          builder: (context, _) {
            return Column(
              children: [
                SizedBox(
                  child: Center(
                    child: Row(
                      children: [
                        DropdownButton<String>(
                            value: currencyController.codeCurrent,
                            items: currencyController.currencys
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                    onTap: () {
                                      log(currency);
                                    },
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              deboucer.run(() async {
                                await currencyController
                                    .onChangeCodeDropDown(value);
                              });
                            }),
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: currencyController.codeControllerText,
                            decoration: const InputDecoration(hintText: "code"),
                            onChanged: (value) {
                              deboucer.run(() async {
                                currencyController.onChangeTextFieldCode(value);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: Center(
                    child: Row(
                      children: [
                        DropdownButton<String>(
                            value: currencyController.codeinCurrent,
                            items: currencyController.currencys
                                .map(
                                  (currency) => DropdownMenuItem(
                                    value: currency,
                                    child: Text(currency),
                                    onTap: () {
                                      log(currency);
                                    },
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              deboucer.run(() async {
                                await currencyController
                                    .onChangeCodeinDropDown(value);
                              });
                            }),
                        const SizedBox(
                          width: 50,
                        ),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              controller:
                                  currencyController.codeinControllerText,
                              onChanged: (value) {
                                deboucer.run(() async {
                                  await currencyController
                                      .onChangeTextFieldCodein(value);
                                });
                              },
                              decoration:
                                  const InputDecoration(hintText: "codein")),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () async {
                        await currencyController.replaceCodeByCodein(
                            currencyController.codeCurrent,
                            currencyController.codeinCurrent);
                      },
                      child: const Icon(Icons.compare_arrows)),
                )
              ],
            );
          }),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
