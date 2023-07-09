import 'package:flutter/material.dart';

class ConverterCurrencyButton extends StatelessWidget {
  const ConverterCurrencyButton({super.key, required this.onConvert});
  final GestureTapCallback onConvert;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .5,
      height: MediaQuery.sizeOf(context).height * .1,
      child: ElevatedButton(
        onPressed: onConvert,
        style: const ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)))),
            backgroundColor: MaterialStatePropertyAll(
              Color(0xFF5369e1),
            )),
        child: const Center(
          child: Text(
            "converter",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
