import 'package:gerencia_de_estado/strategy/imc_calculator.dart';

class IMCCalculatorContext {
  final IMCCalculator calculator;

  IMCCalculatorContext({required this.calculator});

  String calcularIMC(double peso, double altura) {
    return calculator.calcular(peso, altura);
  }
}
