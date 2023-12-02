import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ImcValueNotifyPage extends StatefulWidget {
  const ImcValueNotifyPage({Key? key}) : super(key: key);

  @override
  State<ImcValueNotifyPage> createState() => _ImcValueNotifyPageState();
}

class _ImcValueNotifyPageState extends State<ImcValueNotifyPage> {
  final formKey = GlobalKey<FormState>();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  var imc = ValueNotifier(0.0);
  var result = ValueNotifier<String>("");

  void _calcularIMC({
    required double peso,
    required double altura,
  }) {
    //imc = peso / (altura * altura);
    imc.value = peso / pow(altura, 2);
    if (imc.value < 18.5) {
      result.value = 'Abaixo do peso';
    } else if (imc.value >= 18.5 && imc.value < 25) {
      result.value = 'Peso normal';
    } else if (imc.value >= 25 && imc.value < 30) {
      result.value = 'Sobrepeso';
    } else {
      result.value = 'Obesidade';
    }
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
          title: const Text('Value Notify Manager'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ValueListenableBuilder<String>(
                      valueListenable: result,
                      builder: (_, value, __) => Text(
                            "RESTULTADO: $value",
                          )),
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
