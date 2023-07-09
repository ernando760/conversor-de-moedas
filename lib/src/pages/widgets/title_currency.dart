import 'package:flutter/material.dart';

class TitleCurrency extends StatelessWidget {
  const TitleCurrency({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15, top: 25),
      width: MediaQuery.sizeOf(context).width * .9,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(83, 105, 255, 1),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
