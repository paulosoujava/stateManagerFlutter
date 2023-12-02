import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/block_pattern/stream_page.dart';
import 'package:gerencia_de_estado/change_notify/imc_change_notify.dart';
import 'package:gerencia_de_estado/set_state/imc_set_state.dart';
import 'package:gerencia_de_estado/value_notify/imc_value_notify.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  void _goToPAge(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estate Manager'),
        ),
        body: Center(
          child: Column(children: [
            ElevatedButton(
              onPressed: () =>
                  widget._goToPAge(context, const ImcSetStatePage()),
              child: const Text('SET STATE'),
            ),
            ElevatedButton(
              onPressed: () {
                widget._goToPAge(context, const ImcChangeNotifyPage());
              },
              child: const Text('CHANGE NOTIFIER'),
            ),
            ElevatedButton(
              onPressed: () {
                widget._goToPAge(context, const ImcValueNotifyPage());
              },
              child: const Text('VALUE NOTIFIER'),
            ),
            ElevatedButton(
              onPressed: () {
                widget._goToPAge(context, const ImcStreamPage());
              },
              child: const Text('BLOC PATTERN STREAMS'),
            ),
          ]),
        ));
  }
}
