import 'dart:async';

import 'package:conversor_de_moedas/src/pages/widgets/converter_currency_button.dart';

import '../pages/widgets/box_currency_custom.dart';
import '../pages/widgets/replace_currency_button.dart';
import '../pages/widgets/title_currency.dart';
import '../states/currency_state.dart';
import 'package:flutter/material.dart';

import '../../src/pages/controllers/currency_controller.dart';
import '../../src/repositories/currency_repository_impl.dart';

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

    Future(() async => await currencyController.getAllCurrencys());
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: currencyController,
        builder: (context, state, _) {
          if (state.currencyBase != null && state.currencyTarget != null) {
            return Scaffold(
              backgroundColor: const Color(0xFFF2F2F2),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: const Color(0xFFF2F2F2),
                elevation: 0,
                flexibleSpace: state is LoadingCurrencyState
                    ? const LinearProgressIndicator()
                    : Container(),
                title: const Text(
                  "Conversor de moedas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: state is FailureCurrencyState
                  ? Center(
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.message),
                            ElevatedButton(
                                onPressed: () async {
                                  await currencyController.getAllCurrencys();
                                },
                                child: const Icon(Icons.loop))
                          ],
                        ),
                      ),
                    )
                  : state is LoadingCurrencyState ||
                          state is SuccessCurrencyState
                      ? Center(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height,
                            decoration:
                                const BoxDecoration(color: Color(0xFFF2F2F2)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TitleCurrency(
                                      title:
                                          "${state.currencyBase!.name}/${state.currencyTarget!.name}"),
                                  BoxCurrencyCustom(
                                    isCurrencyBase: true,
                                    currencyControllerText: currencyController
                                        .currencyBaseControllerText,
                                    label: "base",
                                    currencyCode: state.currencyBase!.code,
                                    symbol: state.currencyBase!.symbol,
                                    currencies: state.currencies,
                                    onchangeDropBox: currencyController
                                        .onChangeCurrencyBaseDropDown,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  BoxCurrencyCustom(
                                    amount: state.amount ?? "0",
                                    currencyCode: state.currencyTarget!.code,
                                    symbol: state.currencyTarget!.symbol,
                                    currencies: state.currencies,
                                    onchangeDropBox: currencyController
                                        .onChangeCurrencyTargetDropDown,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ReplaceCurrencyButton(
                                              onPressed: () async {
                                            await currencyController
                                                .replaceCurrencyBaseByCurrencyTarget(
                                                    state.currencyBase!.code,
                                                    state.currencyTarget!.code);
                                          }),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ConverterCurrencyButton(
                                            onConvert: () => currencyController
                                                .convertCurrency(
                                                    base: state
                                                        .currencyBase!.code,
                                                    target: state
                                                        .currencyTarget!.code,
                                                    value: currencyController
                                                        .currencyBaseControllerText
                                                        .text),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
            );
          }
          return Scaffold(
            body: Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        "Problema de conexão no nosso serviço por favor tente mais tarde"),
                    ElevatedButton(
                        onPressed: () async {
                          await currencyController.getAllCurrencys();
                        },
                        child: const Icon(Icons.loop))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
