import 'dart:developer';

import 'package:conversor_de_moedas/src/enviroment/enviroment_variables_api.dart';
import 'package:conversor_de_moedas/src/pages/home_page.dart';
import 'package:flutter/material.dart';

late final EnviromentVariablesAPI enviroment;

void main() {
  enviroment = EnviromentVariablesAPI();
  log(enviroment.urlBase, name: "url base");
  log("${enviroment.apiKey}", name: "api key");
  runApp(const MaterialApp(
    title: 'conversor de moedas',
    home: HomePage(),
  ));
}
