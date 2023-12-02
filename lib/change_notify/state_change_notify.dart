import 'dart:math';

import 'package:flutter/material.dart';

class StateChangeNotify extends ChangeNotifier {
  var imc = 0.0;
  var result = "";

  void calcularIMC({
    required double peso,
    required double altura,
  }) {
    //imc = peso / (altura * altura);

    imc = peso / pow(altura, 2);
    if (imc < 18.5) {
      result = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 25) {
      result = 'Peso normal';
    } else if (imc >= 25 && imc < 30) {
      result = 'Sobrepeso';
    } else {
      result = 'Obesidade';
    }
    notifyListeners();
  }
}
