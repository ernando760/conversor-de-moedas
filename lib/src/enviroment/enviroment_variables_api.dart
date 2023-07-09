class EnviromentVariablesAPI {
  final urlBase = "http://192.168.1.197:3000";
  static const _apikey = String.fromEnvironment("APIKEY");

  get apiKey => _apikey;
}
