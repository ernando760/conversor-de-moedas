// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ReplaceCurrencyButton extends StatelessWidget {
  const ReplaceCurrencyButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .2,
      height: MediaQuery.sizeOf(context).height * .1,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
              iconColor: const MaterialStatePropertyAll(Color(0xff5369e1)),
              backgroundColor: const MaterialStatePropertyAll(Colors.white)),
          onPressed: onPressed,
          child: const Icon(Icons.compare_arrows)),
    );
  }
}
