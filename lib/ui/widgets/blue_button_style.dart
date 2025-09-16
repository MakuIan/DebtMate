import 'package:flutter/material.dart';

class AppBlueButtonStyles {
  static final elevated = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 15),
    backgroundColor: const Color.fromARGB(255, 0, 126, 244),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    foregroundColor: Colors.white,
  );
}
