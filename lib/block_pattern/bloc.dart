import 'dart:async';
import 'dart:math';

class ImcState {
  double imc;
  String result;

  ImcState({required this.imc, required this.result});
}

class BlocPattern {
  final _imcStreamController = StreamController<ImcState>()
    ..add(ImcState(imc: 0, result: ''));

  Stream<ImcState> get imcOut => _imcStreamController.stream;

  void dispose() {
    _imcStreamController.close();
  }

  Future<void> calculate({required double peso, required double altura}) async {
    final imcResult = peso / pow(altura, 2);
    _imcStreamController
        .add(ImcState(imc: imcResult, result: getResult(imcResult)));
  }

  String getResult(double imc) {
    var result = "";
    if (imc < 18.5) {
      result = 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 25) {
      result = 'Peso normal';
    } else if (imc >= 25 && imc < 30) {
      result = 'Sobrepeso';
    } else {
      result = 'Obesidade';
    }

    return result;
  }
}
