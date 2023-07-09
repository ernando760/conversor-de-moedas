import 'dart:developer';

import 'package:flutter/material.dart';

import './app_widget.dart';
import '../../src/enviroment/enviroment_variables_api.dart';

late final EnviromentVariablesAPI enviroment;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  enviroment = EnviromentVariablesAPI();
  log(enviroment.urlBase, name: "url base");
  log("${enviroment.apiKey}", name: "api key");
  runApp(const AppWidget());
}
