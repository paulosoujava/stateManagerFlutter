import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/change_notify/state_change_notify.dart';
import 'package:intl/intl.dart';

class ImcChangeNotifyPage extends StatefulWidget {
  const ImcChangeNotifyPage({Key? key}) : super(key: key);

  @override
  State<ImcChangeNotifyPage> createState() => _ImcChangeNotifyPageState();
}

class _ImcChangeNotifyPageState extends State<ImcChangeNotifyPage> {
  final formKey = GlobalKey<FormState>();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();

  final state = StateChangeNotify();

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
          title: const Text('Change Notify Manager'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AnimatedBuilder(
                      animation: state,
                      builder: (_, __) => Text("RESTULTADO: ${state.result}")),
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
                      state.calcularIMC(
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
