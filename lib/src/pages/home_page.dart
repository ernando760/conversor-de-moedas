import 'dart:async';

import 'package:flutter/material.dart';

import '../../src/pages/controllers/currency_controller.dart';
import '../../src/pages/widgets/currency_dropdown_button.dart';
import '../../src/pages/widgets/text_field_currency.dart';
import '../../src/repositories/currency_repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currencyController = CurrencyController(CurrencyRepositoryImpl());
  final deboucer = Debouncer(milliseconds: 300);
  @override
  void initState() {
    super.initState();
    Future(() async {
      await currencyController.getAllCurrencys();
    });
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
            return SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      currencyController.titleConvert,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CurrencyDropDownButton(
                            codeCurrent: currencyController.codeCurrent,
                            currencys: currencyController.currencies,
                            onChanged: (value) {
                              deboucer.run(() async {
                                await currencyController
                                    .onChangeCodeDropDown(value);
                              });
                            }),
                        const SizedBox(
                          width: 50,
                        ),
                        TextFieldCurrency(
                            hintText: 'code',
                            symbol: currencyController.symbols.symbolCode,
                            controller: currencyController.codeControllerText,
                            onChanged: (value) {
                              deboucer.run(
                                () async {
                                  currencyController
                                      .onChangeTextFieldCode(value);
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CurrencyDropDownButton(
                            codeCurrent: currencyController.codeinCurrent,
                            currencys: currencyController.currencies,
                            onChanged: (value) {
                              deboucer.run(() async {
                                await currencyController
                                    .onChangeCodeinDropDown(value);
                              });
                            }),
                        const SizedBox(
                          width: 50,
                        ),
                        TextFieldCurrency(
                          hintText: 'codein',
                          symbol: currencyController.symbols.symbolCodein,
                          controller: currencyController.codeinControllerText,
                          onChanged: (value) {
                            deboucer.run(() async {
                              await currencyController
                                  .onChangeTextFieldCodein(value);
                            });
                          },
                        ),
                      ],
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
              ),
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
