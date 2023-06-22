class EnviromentVariablesAPI {
  final urlBase = "https://api.freecurrencyapi.com/v1/";
  static const _apikey = String.fromEnvironment("APIKEY");

  get apiKey => _apikey;
}
