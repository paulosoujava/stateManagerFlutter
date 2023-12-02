import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

class ImcSetStatePage extends StatefulWidget {
  const ImcSetStatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetStatePage> createState() => _ImcSetStatePageState();
}

class _ImcSetStatePageState extends State<ImcSetStatePage> {
  final formKey = GlobalKey<FormState>();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  var imc = 0.0;

  void _calcularIMC({
    required double peso,
    required double altura,
  }) {
    setState(() {
      //imc = peso / (altura * altura);
      imc = peso / pow(altura, 2);
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
                  if (imc != 0)
                    Text(
                      "RESTULTADO: $imc",
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

                      _calcularIMC(
                        peso: double.parse(pesoEC.text),
                        altura: double.parse(alturaEC.text),
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
