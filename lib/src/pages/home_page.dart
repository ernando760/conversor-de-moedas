import 'dart:async';

import 'package:conversor_de_moedas/src/pages/controllers/currency_controller.dart';
import 'package:conversor_de_moedas/src/pages/widgets/currency_dropdown_button.dart';
import 'package:conversor_de_moedas/src/pages/widgets/text_field_currency.dart';
import 'package:conversor_de_moedas/src/repositories/currency_repository_impl.dart';
import 'package:flutter/material.dart';

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
      // await currencyController.convertCurrency(
      //     code: "USD", codein: "BRL", value: "1");
      // await currencyController.getCombinationsCurrencys();
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
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CurrencyDropDownButton(
                            codeCurrent: currencyController.codeCurrent,
                            currencys: currencyController.currencys,
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
                            currencys: currencyController.currencys,
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
