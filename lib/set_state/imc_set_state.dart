
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/strategy/calculate/imc_calculate_default.dart';
import 'package:gerencia_de_estado/strategy/context/context_calculate_strategy.dart';
import 'package:intl/intl.dart';

class ImcSetStatePage extends StatefulWidget {
  const ImcSetStatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetStatePage> createState() => _ImcSetStatePageState();
}

class _ImcSetStatePageState extends State<ImcSetStatePage> {
  // Exemplo de uso do padrão Strategy
  IMCCalculatorContext contextStrategy =
      IMCCalculatorContext(calculator: IMCDefaultCalculator());

  final formKey = GlobalKey<FormState>();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  //var imc = 0.0;
  var result = "";

  void _calcularIMC({
    required double peso,
    required double altura,
  }) {
    setState(() {
      //imc = peso / (altura * altura);
      //imc = peso / pow(altura, 2);
      result = contextStrategy.calcularIMC(peso, altura);
      /*if (imc < 18.5) {
        result = 'Abaixo do peso';
      } else if (imc >= 18.5 && imc < 25) {
        result = 'Peso normal';
      } else if (imc >= 25 && imc < 30) {
        result = 'Sobrepeso';
      } else {
        result = 'Obesidade';
      }
      */
    });
  }

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Set State Manager'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (result.isNotEmpty)
                    Text(
                      "RESTULTADO\n$result",
                      style: const TextStyle(
                        fontSize: 34,
                      ),
                    ),
                  TextFormField(
                    controller: pesoEC,
                    decoration: const InputDecoration(labelText: "PESO"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2,
                      )
                    ],
                    validator: (String? peso) {
                      if (peso == null || peso.isEmpty) {
                        return 'Peso obrigatorio';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: alturaEC,
                    decoration: const InputDecoration(labelText: "ALTURA"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR',
                        symbol: '',
                        turnOffGrouping: true,
                        decimalDigits: 2,
                      )
                    ],
                    validator: (String? alt) {
                      if (alt == null || alt.isEmpty) {
                        return 'ALtura obrigatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var validate = formKey.currentState?.validate();

                      if (validate == null || validate == false) {
                        return;
                      }
                      var format = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      _calcularIMC(
                        peso: format.parse(pesoEC.text) as double,
                        altura: format.parse(alturaEC.text) as double,
                      );
                    },
                    child: const Text('CALCULAR'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
