// Estratégia para o IMC com a fórmula padrão
// AQUI ESTA O PADRÃO STRATEGY
import 'package:gerencia_de_estado/strategy/imc_calculator.dart';

class IMCDefaultCalculator implements IMCCalculator {
  @override
  String calcular(double peso, double altura) {
    double imc = peso / (altura * altura);
    return _getStatusPeso(imc);
  }

  String _getStatusPeso(double imc) {
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 25) {
      return 'Peso normal';
    } else if (imc >= 25 && imc < 30) {
      return 'Sobrepeso';
    } else {
      return 'Obesidade';
    }
  }
}